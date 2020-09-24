//
//  SignUpViewController.swift
//  SmartConnection
//
//  Created by Robinson Paz Jesus on 9/24/20.
//  Copyright © 2020 Robinson Paz Jesus. All rights reserved.
//

import UIKit

class GetStartedViewController: UIViewController {
    
    // MARK: - Properties
    let viewModel = SignUpViewModel()

    // MARK: - UI Properties
    @IBOutlet weak var nameField: UITextField!
    @IBOutlet weak var emailField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    
    // MARK: - Init
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        bind()
    }
    
    private func setupViews() {
        view.backgroundColor = .clear
    }
    
    private func bind() {
        viewModel.delegate = self
    }
    
    @IBAction func didTapIHaveAccount(_ sender: Any) {
        guard let pageVC = parent as? AuthenticateViewController else { return }
        pageVC.setViewControllers([pageVC.signInViewController], direction: .forward, animated: true)
    }
    
}

// MARK: ⚡️ Actions

extension GetStartedViewController {
    
    @IBAction func didTapGetStarted(_ sender: Any) {
        let signUpViewController = SignUpViewController()
        let signupNav = UINavigationController(rootViewController: signUpViewController)
        signupNav.modalPresentationStyle = .fullScreen
        present(signupNav, animated: true, completion: nil)
    }
}

// MARK: ❇️ SignUpDelegate

extension GetStartedViewController: SignUpDelegate {
    
    func signUp(didStart: Bool) {
//        presentLoader(message: "Signing up...")
    }

    func signUp(didSucceed: Bool) {
//        dismissLoader()
        if didSucceed {
//            routeManager.displayUserHome()
        } else {
            presentError(message: "Sign up did not work. Please try again later.")
        }
    }
}
