//
//  CodeVerifyViewController.swift
//  HealthyLivingOptimized
//
//  Created by Robinson Paz Jesus on 9/24/20.
//  Copyright © 2020 Unagi Lab. All rights reserved.
//

import UIKit

class CodeVerifyViewController: UIViewController {
    
    
    // MARK: - UI Properties
    @IBOutlet weak var codeField: UITextField!
    @IBOutlet weak var resendButton: UIButton!
    
    var authNetwork = AuthNetwork()
    var email: String!
    
    
    // MARK: - Init
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        bind()
    }
    
    private func setupViews() {
        codeField.becomeFirstResponder()
    }
    
    private func bind() {
        codeField.delegate = self
    }
    
    // MARK: - Helper functions
    @IBAction func didTapResend(_ sender: Any) {
        codeField.text = ""
        let loader = animateLoader()
        
        authNetwork.resendCode(to: self.email) { (succeeded, message) in
            loader.stopAnimating()
        }
    }
    
    // MARK: - Storyboard Helper
    
    static func createAreference() -> CodeVerifyViewController {
        
        let storyboard = UIStoryboard(name: "Authenticate", bundle: nil)
        if let controller = storyboard.instantiateViewController(withIdentifier: "CodeVerifyViewController") as? CodeVerifyViewController {
            return controller
        } else {
            return CodeVerifyViewController()
        }
    }
}

extension CodeVerifyViewController: UITextFieldDelegate {
    
    // Verifies the code when it hits 6 chars
    func textFieldDidChangeSelection(_ textField: UITextField) {
        guard let code = textField.text else { return }
        if code.count != 6 { return }
        
        let loader = animateLoader()
        
        authNetwork.verifyCode(code: code, for: self.email) { [weak self] (isCodeCorrect, errorMessage) in
            if isCodeCorrect {
                routeManager.displayMain()
            } else {
                loader.stopAnimating()
                textField.text = ""
                self?.presentError(title: "Incorrect code", message: errorMessage ?? "Please enter the correct code")
            }
        }
    }
    
    // Limits the length to 6 chars
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        guard let textFieldText = textField.text,
            let rangeOfTextToReplace = Range(range, in: textFieldText) else {
                return false
        }
        let substringToReplace = textFieldText[rangeOfTextToReplace]
        let count = textFieldText.count - substringToReplace.count + string.count
        return count <= 6
    }
    
}
