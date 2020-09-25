//
//  AuthServiceHelper.swift
//  HealthyLivingOptimized
//
//  Created by Robinson Paz Jesus on 8/26/20.
//  Copyright © 2020 Unagi Lab. All rights reserved.
//

import Foundation
import AWSCognitoIdentityProvider

class AuthServiceHelper {
    
    
    class func getUserAttributes(email: String,
                                 firstName: String,
                                 lastName: String) -> [AWSCognitoIdentityUserAttributeType] {
        var attributes = [AWSCognitoIdentityUserAttributeType]()

        let emailAttr = AWSCognitoIdentityUserAttributeType()
        emailAttr?.name = "email"
        emailAttr?.value = email
        attributes.append(emailAttr!)

        let nameAttr = AWSCognitoIdentityUserAttributeType()
        nameAttr?.name = "name"
        nameAttr?.value = "\(firstName) \(lastName)"
        attributes.append(nameAttr!)

        return attributes
    }
    
    class func getMetadata(firstName: String,
                           lastName: String,
                           email: String,
                           weight: Double,
                           age: Int,
                           gender: String,
                           goal: String,
                           goalWeight: Double) -> [String: String] {
        var clientMetaData = [String: String]()
        clientMetaData["firstName"] = firstName
        clientMetaData["lastName"] = lastName
        clientMetaData["email"] = email
        clientMetaData["weight"] = String(weight)
        clientMetaData["age"] = String(age)
        clientMetaData["gender"] = gender
        clientMetaData["goal"] = goal
        clientMetaData["goalWeight"] = String(goalWeight)
        return clientMetaData
    }
}
