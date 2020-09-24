//
//  SignUpViewController.swift
//  HealthyLivingOptimized
//
//  Created by Robinson Paz Jesus on 9/24/20.
//  Copyright © 2020 Unagi Lab. All rights reserved.
//

import UIKit

class SignUpViewController: ScrollViewController {
    
    
    // MARK: - Properties
//    let signupForm = SignUpForm()
    
    
    // MARK: - UI Properties
//    let bottomView = BottomButtonView()
    
    
    
    // MARK: - Init
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        bind()
    }
    
    private func setupViews() {
        view.backgroundColor = Assets.Color.pages
        title = "Create Account"
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(self.handleDismiss))
        
        ///
//        contentView.addSubview(signupForm)
//        signupForm.anchor(top: contentView.safeAreaLayoutGuide.topAnchor, left: contentView.leftAnchor, bottom: contentView.bottomAnchor, right: contentView.rightAnchor, tCons: 0, lCons: 16, bCons: 0, rCons: 16)
//
//        /// Bottom view
//        bottomView.applyButton.setTitle("Sign Up", for: .normal)
//        bottomView.applyButton.backgroundColor = Assets.Color.darkText
//        bottomView.applyButton.tintColor = Assets.Color.cellWhite
//        view.addSubview(bottomView)
//        bottomView.anchor(left: view.leftAnchor, bottom: view.bottomAnchor, right: view.rightAnchor, heightCons: 100)
    }
    
    private func bind() {
//        bottomView.applyButton.addTarget(self, action: #selector(didTapSignUp), for: .touchUpInside)
//        signupForm.delegate = self
    }
    
    
    // MARK: - Helper functions
    @objc private func didTapSignUp() {
        
//        guard signupForm.isFormCompleted() else {
//            print("Missing something")
//            return
//        }
//
//        let loader = animateLoader()
//
//        let authNetwork = AuthNetwork()
//        authNetwork.signUp(name: signupForm.name,
//                                     career: signupForm.career,
//                                     internship: signupForm.internshipCheck,
//                                     summerJob: signupForm.summerJobCheck,
//                                     entryJob: signupForm.entryLevelCheck,
//                                     email: signupForm.email,
//                                     password: signupForm.password,
//                                     userType: signupForm.type == .student ? "IND" : "COMP")
//        { [weak self] (success, message) in
//            loader.stopAnimating()
//
//            if success { /// SignUp and SignIn succeeded
//                let codeViewController = CodeVerifyViewController.createAreference()
//                codeViewController.email = self?.signupForm.email
//                codeViewController.authNetwork = authNetwork
//                self?.navigationController?.pushViewController(codeViewController, animated: true)
//            } else {
//                self?.presentError(message: message)
//            }
//        }
    }
}


// MARK: - SignUpFormDelegate
//extension SignUpViewController: SignUpFormDelegate {
//
//    func formDidChange(to type: SignUpForm.SignUpFormType) {
//
//
//    }
//}
