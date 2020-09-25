//
//  SignUpViewController.swift
//  HealthyLivingOptimized
//
//  Created by Robinson Paz Jesus on 9/24/20.
//  Copyright © 2020 Unagi Lab. All rights reserved.
//

import UIKit
import Eureka

class SignUpViewController: FormViewController {
    
    var firstName: String!
    var lastName: String!
    var email: String!
    var password: String!
    
    var height: Double!
    var currentWeight: Double!
    var age: Int!
    var gender: String!
    
    var goal: String!
    var goalWeight: Double!
    
    // MARK: - Init
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
    }
    
    private func setupViews() {
        title = "Create Account"
        navigationController?.navigationBar.prefersLargeTitles = true
        view.backgroundColor = Assets.Color.pages
        navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(handleDismiss))
        
        /// Form
        form
            
            /// Info
            +++ Section(header: "Info", footer: nil)
            <<< NameRow(){ row in
                row.title = "First Name"
                row.value = "Rob"
                row.placeholder = ""
                self.firstName = row.value
            }.onChange{ row in
                self.firstName = row.value
            }
            <<< NameRow(){ row in
                row.title = "Last Name"
                row.value = "Paz"
                row.placeholder = ""
                self.lastName = row.value
            }.onChange{ row in
                self.lastName = row.value
            }
            <<< EmailRow() { row in
                row.title = "Email"
                row.value = "robinson.paz.jesus+@gmail.com"
                self.email = row.value
            }.onChange{ row in
                self.email = row.value
            }
            <<< PasswordRow() { row in
                row.title = "Password"
                row.value = "password"
                self.password = row.value
            }.onChange{ row in
                self.password = row.value
            }
            
            /// Current Stats
            +++ Section(header: "Current Stats", footer: "")
            <<< DecimalRow { row in
                row.title = "Height(In)"
                row.value = 70
                self.height = row.value
            }.onChange({ row in
                self.height = row.value
            })
            <<< DecimalRow { row in
                row.title = "Weight(lbs)"
                row.value = 200.0
                self.currentWeight = row.value
            }.onChange({ row in
                self.currentWeight = row.value
            })
            <<< IntRow { row in
                row.title = "Age"
                row.value = 27
                self.age = row.value
            }.onChange{ row in
                self.age = row.value
            }
            <<< ActionSheetRow<String>() {
                $0.title = "Gender"
                $0.selectorTitle = "Pick a gender"
                $0.options = ["Male", "Female"]
                $0.value = "Male"
                self.gender = $0.value
            }.onChange{ row in
                self.gender = row.value
            }
            
            /// Goals
            +++ Section(header: "Goals", footer: "")
            <<< TextRow { row in
                row.title = "Goal"
                row.value = "I want to loose weight and be more active."
                self.goal = row.value
            }.onChange{ row in
                self.goal = row.value
            }
            <<< DecimalRow { row in
                row.title = "Target Weight(lbs)"
                row.value = 180.0
                self.goalWeight = row.value
            }.onChange{ row in
                self.goalWeight = row.value
            }
            
        +++ Section(header: "", footer: "")
            <<< ButtonRow { row in
                row.title = "Create Account"
        }.onCellSelection {  cell, row in self.didTapCreateAccount() }
        
    }
    
    @objc private func didTapCreateAccount() {
        /// Get Values
//        guard let firstName = self.firstName else { return }
//        guard let lastName = self.lastName else { return }
//        guard let email = self.email else { return }
//        guard let password = self.password else { return }
//
//        guard let height = self.height else { return }
//        guard let currentWeight = self.currentWeight else { return }
//        guard let age = self.age else { return }
//        guard let gender = self.gender else { return }
//
//        guard let goal = self.goal else { return }
//        guard let goalWeight = self.goalWeight else { return }
        
        /// Call AWS
        let loader = animateLoader()
        let authNetwork = AuthNetwork()
        authNetwork.signUp(firstName: firstName,
                           lastName: lastName,
                           email: email,
                           password: password,
                           height: height,
                           currentWeight: currentWeight,
                           age: age,
                           gender: gender,
                           goal: goal,
                           goalWeight: goalWeight)
        { [weak self] (success, message) in
            loader.stopAnimating()
            
            if success { /// SignUp and SignIn succeeded
                let codeViewController = CodeVerifyViewController.createAreference()
                codeViewController.email = self?.email
                codeViewController.authNetwork = authNetwork
                self?.navigationController?.pushViewController(codeViewController, animated: true)
            } else {
                self?.presentError(message: message)
            }
        }
        
    }
}
