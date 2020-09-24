//
//  SignInViewController.swift
//  SmartConnection
//
//  Created by Robinson Paz Jesus on 9/24/20.
//  Copyright © 2020 Robinson Paz Jesus. All rights reserved.
//

import UIKit
import NVActivityIndicatorView

class SignInViewController: UIViewController {
    
    // MARK: - Properties
    let viewModel = SignInViewModel()
    
    // MARK: - UI Properties
    @IBOutlet weak var emailField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    var loader: NVActivityIndicatorView?
    
    // MARK: - Init
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        bind()
        emailField.text = "robinson.paz.jesus+5@gmail.com"
        passwordField.text = "asd123!AA"
    }
    
    private func setupViews() {
        view.backgroundColor = .clear
        emailField.themed(placeholder: "Email")
        passwordField.themed(placeholder: "Password")
    }
    
    private func bind() {
        viewModel.delegate = self
    }
}

// MARK: ⚡️ Actions

extension SignInViewController {
    
    @IBAction func didTapSignIn(_ sender: Any) {
        guard let email = emailField.text, let password = passwordField.text else { return }
        viewModel.signIn(email: email, password: password)
    }
    
    @IBAction func didTapForgotPassword(_ sender: Any) {
        
    }
    
    
    
    @IBAction func didTapDontHaveAccount(_ sender: Any) {
        guard let pageVC = parent as? AuthenticateViewController else { return }
        pageVC.setViewControllers([pageVC.getStartedViewController], direction: .reverse, animated: true)
    }
}

// MARK: ❇️ SignInDelegate

extension SignInViewController: SignInDelegate {
    
    func signIn(didStart: Bool) {
//        loader = animateLoader()
    }
    
    func signInDidFinish(didSucceed: Bool, errorMessage: String?) {
        loader?.stopAnimating()
        
//        if didSucceed {
//            routeManager.displayMain()
//        } else {
//            presentError(message: errorMessage ?? "Sign in did not work. Please try again later.")
//        }
    }
    
}
