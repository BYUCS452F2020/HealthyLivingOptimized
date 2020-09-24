//
//  SignUpViewController.swift
//  HealthyLivingOptimized
//
//  Created by Robinson Paz Jesus on 9/24/20.
//  Copyright © 2020 Unagi Lab. All rights reserved.
//

import UIKit

import UIKit
import Eureka
//import ViewRow

class SignUpViewController: FormViewController {
    
    
    // MARK: - UI Properties
//    let editPhotoView = EditPhotoView(frame: CGRect(x: 0, y: 0, width: 100, height: 150))
    
    
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
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .save, target: self, action: #selector(didTapSave))
        
//        let profile = LocalDatabase.shared.getUser()
        
        
//        editPhotoView.avatarView.set(with: profile?.imageUrl, placeholder: nil)
//        editPhotoView.delegate = self
        
        /// Form
        form
            
            /// Info
            +++ Section(header: "Info", footer: nil)
            <<< NameRow(){ row in
                row.title = "First Name"
                row.placeholder = ""
            }
            <<< NameRow(){ row in
                row.title = "Last Name"
                row.placeholder = ""
            }
            <<< EmailRow() { row in
                row.title = "Email"
            }
            
            /// Current Stats
            +++ Section(header: "Current Stats", footer: "")
            <<< DecimalRow { row in
                row.title = "Weight"
            }
            <<< DecimalRow { row in
                row.title = "Age"
            }
            <<< PickerRow<String> { row in
                row.title = "Gender"
                row.options = ["Male", "Female", "Other"]
                
            }
    }
    
    @objc private func didTapSave() {
        /// Update Photo
    }
}




//class SignUpViewController: ScrollViewController {
//
//
//    // MARK: - Properties
////    let signupForm = SignUpForm()
//
//
//    // MARK: - UI Properties
////    let bottomView = BottomButtonView()
//
//
//
//    // MARK: - Init
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        setupViews()
//        bind()
//    }
//
//    private func setupViews() {
//        view.backgroundColor = Assets.Color.pages
//        title = "Create Account"
//        navigationController?.navigationBar.prefersLargeTitles = true
//        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(self.handleDismiss))
//
//        ///
////        contentView.addSubview(signupForm)
////        signupForm.anchor(top: contentView.safeAreaLayoutGuide.topAnchor, left: contentView.leftAnchor, bottom: contentView.bottomAnchor, right: contentView.rightAnchor, tCons: 0, lCons: 16, bCons: 0, rCons: 16)
////
////        /// Bottom view
////        bottomView.applyButton.setTitle("Sign Up", for: .normal)
////        bottomView.applyButton.backgroundColor = Assets.Color.darkText
////        bottomView.applyButton.tintColor = Assets.Color.cellWhite
////        view.addSubview(bottomView)
////        bottomView.anchor(left: view.leftAnchor, bottom: view.bottomAnchor, right: view.rightAnchor, heightCons: 100)
//    }
//
//    private func bind() {
////        bottomView.applyButton.addTarget(self, action: #selector(didTapSignUp), for: .touchUpInside)
////        signupForm.delegate = self
//    }
//
//
//    // MARK: - Helper functions
//    @objc private func didTapSignUp() {
//
////        guard signupForm.isFormCompleted() else {
////            print("Missing something")
////            return
////        }
////
////        let loader = animateLoader()
////
////        let authNetwork = AuthNetwork()
////        authNetwork.signUp(name: signupForm.name,
////                                     career: signupForm.career,
////                                     internship: signupForm.internshipCheck,
////                                     summerJob: signupForm.summerJobCheck,
////                                     entryJob: signupForm.entryLevelCheck,
////                                     email: signupForm.email,
////                                     password: signupForm.password,
////                                     userType: signupForm.type == .student ? "IND" : "COMP")
////        { [weak self] (success, message) in
////            loader.stopAnimating()
////
////            if success { /// SignUp and SignIn succeeded
////                let codeViewController = CodeVerifyViewController.createAreference()
////                codeViewController.email = self?.signupForm.email
////                codeViewController.authNetwork = authNetwork
////                self?.navigationController?.pushViewController(codeViewController, animated: true)
////            } else {
////                self?.presentError(message: message)
////            }
////        }
//    }
//}
//
//
//// MARK: - SignUpFormDelegate
////extension SignUpViewController: SignUpFormDelegate {
////
////    func formDidChange(to type: SignUpForm.SignUpFormType) {
////
////
////    }
////}
