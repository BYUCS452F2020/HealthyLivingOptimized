//
//  NetworkProxy.swift
//  HealthyLivingOptimized
//
//  Created by Robinson Paz Jesus on 7/30/20.
//  Copyright © 2020 Unagi Lab. All rights reserved.
//

import PromiseKit
import KeychainAccess
import Alamofire

public typealias JSON = [String: Any]

/// This class
class NetworkProxy {
    
    public enum ServerURL: String {
        case base = "https://buuam494oj.execute-api.us-east-1.amazonaws.com/prod"
    }
    
    static let shared = NetworkProxy(baseURL: ServerURL.base)
    var baseURL: String
    let decoder = JSONDecoder()
    let encoder = JSONEncoder()
    
    private let keychain = Keychain(service: "com.HealthyLivingOptimized")
    
    private init(baseURL: ServerURL = .base) {
        self.baseURL = baseURL.rawValue
        self.decoder.keyDecodingStrategy = .convertFromSnakeCase
        encoder.outputFormatting = [.prettyPrinted, .sortedKeys]
        encoder.keyEncodingStrategy = .convertToSnakeCase
    }
    
    func codableRequest<T>(_ resource: Resource, parameters: Codable? = nil, as type: T.Type) -> Promise<T> where T : Decodable {
        return Promise { seal in
            log.info(resource.resource.route, "Route")
            do {
                let url = try "\(baseURL)\(resource.resource.route)".asURL()
                let httpRequest = createHttpRequest(url: url, body: parameters, resource: resource, includeTokens: false)

                log.info("Request for url: \(url)")
//                print("***      \(httpRequest.headers)      ***")
                URLSession.shared.dataTask(.promise, with: httpRequest).validate()
                    .map { args in
//                        print(args.data.toString())
                        let decoded = try self.decode(type, from: args.data)
                        seal.fulfill(decoded)
                }
                .catch { error in
                    seal.reject(error)
                }
            }
            catch {
                seal.reject(error)
            }
        }
    }
    
    func createHttpRequest(url: URL, body: Codable?, resource: Resource, includeTokens: Bool) -> URLRequest {
        var rq = URLRequest(url: url)
        rq.httpMethod = resource.resource.method.rawValue
        rq.addValue("application/json", forHTTPHeaderField: "Content-Type")
        rq.addValue("application/json", forHTTPHeaderField: "Accept")
        
        if includeTokens, let idToken = getIdToken() {
            rq.addValue(idToken, forHTTPHeaderField: "Authorization")
        }
        
        if includeTokens, let authToken = getAuthToken() {
            rq.addValue(authToken, forHTTPHeaderField: "AccessToken")
        }

        if let codable = body, let params = try? self.encode(data: codable){
            log.debug(params.toString(), "Request")
            rq.httpBody = params
        }
        return rq
    }
}

// MARK: - Codable helpers

extension NetworkProxy: EncodeDecode {
    
    func decode <T>(_ type: T.Type, from data: Data) throws -> T where T : Decodable {
        return try decoder.decode(type, from: data)
    }
    
    func encode(data: Codable) throws -> Data {
        let resultDictionary = try data.encode(with: self.encoder)
        return resultDictionary
    }
}

// MARK: - Keychain helpers

extension NetworkProxy {
    
    func setIdToken(idToken: String) throws {
        try self.keychain.set(idToken, key: "idToken")
    }
    
    func setAuthToken(authToken: String) throws {
        try self.keychain.set(authToken, key: "authToken")
    }
    
    func getAuthToken() -> String? {
        return keychain["authToken"]
    }
    
    func getIdToken() -> String? {
        return keychain["idToken"]
    }
    
    func removeAuthToken() throws {
        try self.keychain.remove("authToken")
    }
    
    
    func setEmail(email: String) throws {
        try self.keychain.set(email, key: "userEmail")
    }
    
    func getEmail() -> String? {
        return keychain["userEmail"]
    }
}

