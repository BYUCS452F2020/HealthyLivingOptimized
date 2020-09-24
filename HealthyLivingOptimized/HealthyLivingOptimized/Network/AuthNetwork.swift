//
//  AuthNetwork.swift
//  HealthyLivingOptimized
//
//  Created by Robinson Paz Jesus on 8/26/20.
//  Copyright © 2020 Unagi Lab. All rights reserved.
//

import Foundation

class AuthNetwork {
    
    let authService = AuthService(networkProxy: .shared)
    
    func signUp(name: String, career: String,  internship: Bool, summerJob: Bool, entryJob: Bool, email: String, password: String, userType: String, completed: @escaping (Bool, String?)->Void) {
        authService.signUp(name: name, career: career, internship: internship, summerJob: summerJob, entryJob: entryJob, email: email, password: password, userType: userType, completed: completed)
    }
    
    func signIn(email: String, password: String, completed: @escaping (Bool, String?)->Void) {
        authService.signIn(email: email, password: password, completed: completed)
    }
    
    func signOut() {
        authService.signOut()
    }
    
    func verifyCode(code: String, for email: String, completed: @escaping (Bool, String?)->Void) {
        authService.verifyCode(code: code, for: email, completed: completed)
    }
    
    func resendCode(to email: String, completed: @escaping (Bool, String?)->Void) {
        authService.resendCode(to: email, completed: completed)
    }
}
