//
//  SignUpViewModel.swift
//  SmartConnection
//
//  Created by Robinson Paz Jesus on 3/30/20.
//  Copyright © 2020 Robinson Paz Jesus. All rights reserved.
//

import Foundation

protocol SignUpDelegate {
    func signUp(didStart: Bool)
    func signUp(didSucceed: Bool)
}

class SignUpViewModel {
    
//    let userFetcher = UserFetcher()
    var delegate: SignUpDelegate?
    
    func signUp(email: String, password: String) {
        self.delegate?.signUp(didStart: true)
//        userFetcher.signup(email: email, password: password) { success in
//            self.delegate?.signUp(didSucceed: success)
//        }
    }
    
    func signUpWithLinkedIn() {
        
    }
    
    func signUpWithGoogle() {
        
    }
}
