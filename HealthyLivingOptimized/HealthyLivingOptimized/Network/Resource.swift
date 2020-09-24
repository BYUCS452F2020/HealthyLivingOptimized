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
    case getMyVideos
    case getFeed(String, String, String)
    case getCompany(String)
    
    public var resource: (method: HTTPMethod, route: String, needsToken: Bool) {
        switch self {
        case .getProfile:
            return (.get, "/users/me/myprofile", true)
            
        case .getMyVideos:
            return (.get, "/users/me/myvideos", true)
            
        case .getFeed(let major, let jobType, let state):
            return (.get, "/jobs?major=\(major)&jobType=\(jobType)&city=\(state)", false)
            
        case .getCompany(let id):
            return (.get, "/companies?id=\(id)", false)
        }
    }
}
