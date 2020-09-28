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

    case getProfile
    case getHistory
    case getRecommendation
    case updateProfile
    case postDailyEntry
    
    public var resource: (method: HTTPMethod, route: String) {
        switch self {
        case .getProfile:
            return (.get, "/me/profile")
        case .getHistory:
            return (.get, "/me/history")
        case .getRecommendation:
            return (.get, "/me/recommendation")
        case .updateProfile:
            return (.patch, "/me/profile")
        case .postDailyEntry:
            return (.post, "/me/history")
            
        }
    }
}
