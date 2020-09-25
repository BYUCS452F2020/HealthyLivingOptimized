//
//  AuthService.swift
//  HealthyLivingOptimized
//
//  Created by Robinson Paz Jesus on 8/26/20.
//  Copyright © 2020 Unagi Lab. All rights reserved.
//

import Foundation
import AWSCognitoIdentityProvider

class AuthService: NetworkService {
    
    private let pool = AWSCognitoIdentityUserPool(forKey: AWSCognitoUserPoolsSignInProviderKey)
    
    func signUp(firstName: String, lastName: String,  email: String, password: String, height: Double, currentWeight: Double, age: Int, gender: String, goal: String, goalWeight: Double, completed: @escaping (Bool, String?)->Void) {
        
        /// User Attributes
        let attributes = AuthServiceHelper.getUserAttributes(email: email, firstName: firstName, lastName: lastName)
        let metadata = AuthServiceHelper.getMetadata(firstName: firstName, lastName: lastName, email: email, height: height, weight: currentWeight, age: age, gender: gender, goal: goal, goalWeight: goalWeight)
        
        let defaultErrorMessage = "Please try again later"
        
        pool?.signUp(email, password: password, userAttributes: attributes, validationData: nil, clientMetaData: metadata).continueWith(block: { (task) -> Any? in
            
            DispatchQueue.main.async {
                
                if let error = task.error as NSError? {
                    let errorMessage = (error.userInfo["message"] as? String) ?? defaultErrorMessage
                    log.error(errorMessage)
                    completed(false, errorMessage)
                    return
                    
                } else if let result = task.result  {
                    completed(true, result.userSub)
                    return
                }
                
                completed(false, defaultErrorMessage)
            }
            return nil
        })
    }
    
    
    func signIn(email: String, password: String, completed: @escaping (Bool, String?)->Void) {
        try? networkProxy.removeAuthToken()
        let user = pool?.getUser(email)
        let defaultErrorMessage = "Please try again later"
        
        user?.getSession(email, password: password, validationData: nil).continueWith { [weak self] (task) -> Any? in
            DispatchQueue.main.async {
                if let error = task.error as NSError? {
                    let errorMessage = (error.userInfo["message"] as? String) ?? defaultErrorMessage
                    log.error(error)
                    completed(false, errorMessage)
                    return
                    
                } else if let session = task.result, let authToken = session.accessToken?.tokenString, let idToken = session.idToken?.tokenString {
                    try? self?.networkProxy.setAuthToken(authToken: authToken)
                    try? self?.networkProxy.setIdToken(idToken: idToken)
                    log.debug("Access_Token: \n" + authToken)
                    log.debug("Id_Token: \n" + session.idToken!.tokenString)
                    completed(true, nil)
                    return
                }
                
                completed(false, defaultErrorMessage)
            }
            return nil
        }
    }
    
    func signOut() {
        try? networkProxy.removeAuthToken()
    }
    
    func verifyCode(code: String, for email: String, completed: @escaping (Bool, String?)->Void) {
        let user = pool?.getUser(email)
        
        user?.confirmSignUp(code, clientMetaData: nil).continueWith { (task) -> Any? in
            DispatchQueue.main.async {
                if let error = task.error as NSError? {
                    let errorMessage = error.userInfo["message"] as? String
                    completed(false, errorMessage)

                } else {
                    completed(true, nil)
                }
            }
            return nil
        }
    }
    
    func resendCode(to email: String, completed: @escaping (Bool, String?)->Void) {
        let user = pool?.getUser(email)
        
        user?.resendConfirmationCode().continueWith { (task) -> Any? in
            DispatchQueue.main.async {
                if let error = task.error as NSError? {
                    let errorMessage = error.userInfo["message"] as? String
                    completed(false, errorMessage)
                    
                } else {
                    completed(true, nil)
                }
            }
            return nil
        }
    }
}
