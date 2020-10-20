//
//  Resource.swift
//  HealthyLivingOptimized
//
//  Created by Robinson Paz Jesus on 7/30/20.
//  Copyright © 2020 Unagi Lab. All rights reserved.
//

import Foundation
import Alamofire

public typealias AuthString = String

public enum Resource {

    case getProfile(String)
    case getHistory(String)
    case getRecommendation
    case updateProfile
    case postDailyEntry
    
    public var resource: (method: HTTPMethod, route: String) {
        switch self {
        case .getProfile(let email):
            return (.get, "/me/profile?email=\(email)")
        case .getHistory(let email):
            return (.get, "/me/history?email=\(email)")
        case .getRecommendation:
            return (.get, "/me/recommendation")
        case .updateProfile:
            return (.patch, "/me/profile")
        case .postDailyEntry:
            return (.post, "/me/history")
            
        }
    }
}
