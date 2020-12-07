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
    
    func getProfile(for email: String) -> Promise<ProfileModel> {
        print(">>>> MAKE REQUEST WITH: ", email)
        return networkProxy.codableRequest(.getProfile(email), as: ProfileModel.self)
    }
    
    func getHistory(for email: String) -> Promise<[EntryHistoryModel]> {
        return networkProxy.codableRequest(.getHistory(email), as: [EntryHistoryModel].self)
    }
    
    func postEntry(body: [String:String]) -> Promise<SuccessResponse> {
        return networkProxy.codableRequest(.postDailyEntry, parameters: body, as: SuccessResponse.self)
    }
    
    func deleteEntry(with id: String, for email: String) -> Promise<SuccessResponse> {
        return networkProxy.codableRequest(.deleteEntry(id, email), as: SuccessResponse.self)
    }
    
}


class FetcherController {
    
    let fetcherService = FetcherService(networkProxy: NetworkProxy.shared)
    
    func getProfile() -> Promise<ProfileModel> {
        let email = NetworkProxy.shared.getEmail()!
            
        return fetcherService.getProfile(for: email).map { profileModel -> ProfileModel in
            return profileModel
        }
    }
    
    func getHistory() -> Promise<[EntryHistoryModel]> {
        let email = fetcherService.networkProxy.getEmail()!
        return fetcherService.getHistory(for: email)
    }
    
    func postEntry(body: [String:String]) -> Promise<SuccessResponse> {
        return fetcherService.postEntry(body: body)
    }
    
    func deleteEntry(with id: String, for email: String) -> Promise<SuccessResponse> {
        return fetcherService.deleteEntry(with: id, for: email)
    }
}

struct ProfileModel: Codable {
    var email: String
    var firstName: String
    var lastName: String
    var gender: String
    var age: Int
    var weight: Double
    var height: Double
}

//struct HistoryResponse: Codable {
//    var history: [EntryHistoryModel]
//}

struct EntryHistoryModel: Codable {
    var entryId: String
    var date: String?
    var hoursOfSleep: String
    var gramsOfProtein: String
    var typeOfExercise: String
    var minutesOfExercise: String
    var currentWeight: String
    var mood: String
    var muscleGrowth: String
}

struct SuccessResponse: Codable {
    var success: String
}
