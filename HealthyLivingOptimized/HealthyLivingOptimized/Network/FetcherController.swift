//
//  FetcherController.swift
//  HealthyLivingOptimized
//
//  Created by Robinson Paz Jesus on 10/19/20.
//  Copyright © 2020 Unagi Lab. All rights reserved.
//

import Foundation
import PromiseKit

class FetcherService: NetworkService {
    
    func getProfile() -> Promise<ProfileModel> {
        return networkProxy.codableRequest(.getProfile, as: ProfileModel.self)
    }
    
    func getHistory() -> Promise<[EntryHistoryModel]> {
        return networkProxy.codableRequest(.getHistory, as: [EntryHistoryModel].self)
    }
    
}


class FetcherController {
    
    let fetcherService = FetcherService(networkProxy: NetworkProxy.shared)
    
    func getProfile() -> Promise<ProfileModel> {
        return fetcherService.getProfile()
    }
    
    func getHistory() -> Promise<[EntryHistoryModel]> {
        return fetcherService.getHistory()
    }
}

struct ProfileModel: Codable {
    
}

//struct HistoryResponse: Codable {
//    var history: [EntryHistoryModel]
//}

struct EntryHistoryModel: Codable {
    var date: String?
    var body: String?
}
