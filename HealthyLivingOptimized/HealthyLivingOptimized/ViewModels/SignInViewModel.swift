//
//  SignInViewModel.swift
//  SmartConnection
//
//  Created by Robinson Paz Jesus on 3/31/20.
//  Copyright © 2020 Robinson Paz Jesus. All rights reserved.
//

import Foundation

protocol SignInDelegate {
    func signIn(didStart: Bool)
    func signInDidFinish(didSucceed: Bool, errorMessage: String?)
}

class SignInViewModel {
    
    let authNetwork = AuthNetwork()
    var delegate: SignInDelegate?
    
    func signIn(email: String, password: String) {
        self.delegate?.signIn(didStart: true)
        
        authNetwork.signIn(email: email, password: password) { [weak self] succeed, errorMessage in
            self?.delegate?.signInDidFinish(didSucceed: succeed, errorMessage: errorMessage)
        }
    }
}
