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
                row.placeholder = ""
            }.onChange{ row in
                self.firstName = row.value
            }
            <<< NameRow(){ row in
                row.title = "Last Name"
                row.placeholder = ""
            }.onChange{ row in
                self.lastName = row.value
            }
            <<< EmailRow() { row in
                row.title = "Email"
            }.onChange{ row in
                self.email = row.value
            }
            <<< PasswordRow() { row in
                row.title = "Password"
            }.onChange{ row in
                self.password = row.value
            }
            
            /// Current Stats
            +++ Section(header: "Current Stats", footer: "")
            <<< DecimalRow { row in
                row.title = "Weight(lbs)"
            }.onChange({ row in
                self.currentWeight = row.value
            })
            <<< IntRow { row in
                row.title = "Age"
            }.onChange{ row in
                self.age = row.value
            }
            <<< ActionSheetRow<String>() {
                $0.title = "Gender"
                $0.selectorTitle = "Pick a gender"
                $0.options = ["Male", "Female"]
                $0.value = "Male"
            }.onChange{ row in
                self.gender = row.value
            }
            
            /// Goals
            +++ Section(header: "Goals", footer: "")
            <<< TextRow { row in
                row.title = "Goal"
            }.onChange{ row in
                self.goal = row.value
            }
            <<< DecimalRow { row in
                row.title = "Target Weight(lbs)"
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
        guard let firstName = self.firstName else { return }
        guard let lastName = self.lastName else { return }
        guard let email = self.email else { return }
        guard let password = self.password else { return }
        
        guard let currentWeight = self.currentWeight else { return }
        guard let age = self.age else { return }
        guard let gender = self.gender else { return }
        
        guard let goal = self.goal else { return }
        guard let goalWeight = self.goalWeight else { return }
        
        /// Call AWS
        let authNetwork = AuthNetwork()
        authNetwork.signUp(firstName: firstName, lastName: lastName, email: email, password: password, currentWeight: currentWeight, age: age, gender: gender, goal: goal, goalWeight: goalWeight) { (success, message) in
            
        }
        
    }
}
