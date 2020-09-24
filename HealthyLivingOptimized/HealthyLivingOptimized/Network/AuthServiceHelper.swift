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
    
    
    class func getUserAttributes(email: String, name: String, userType: String) -> [AWSCognitoIdentityUserAttributeType] {
        var attributes = [AWSCognitoIdentityUserAttributeType]()
        
        let emailAttr = AWSCognitoIdentityUserAttributeType()
        emailAttr?.name = "email"
        emailAttr?.value = email
        attributes.append(emailAttr!)
        
        let nameAttr = AWSCognitoIdentityUserAttributeType()
        nameAttr?.name = "name"
        nameAttr?.value = name
        attributes.append(nameAttr!)
        
        let userTypeTypeAttr = AWSCognitoIdentityUserAttributeType()
        userTypeTypeAttr?.name = "custom:user_type"
        userTypeTypeAttr?.value = userType
        attributes.append(userTypeTypeAttr!)
        
        return attributes
    }
    
    class func getMetadata(career: String, internship: Bool, summerJob: Bool, entryJob: Bool) -> [String: String] {
        var clientMetaData = [String: String]()
        clientMetaData["career"] = career
        clientMetaData["internship"] = internship ? "true" : "false"
        clientMetaData["summer_job"] = summerJob ? "true" : "false"
        clientMetaData["entry_job"] = entryJob ? "true" : "false"
        return clientMetaData
    }
}
