//
//  Encoders.swift
//  HealthyLivingOptimized
//
//  Created by Robinson Paz Jesus on 7/30/20.
//  Copyright © 2020 Unagi Lab. All rights reserved.
//

import Foundation

protocol EncodeDecode {
    func encode (data: Codable) throws -> Data
    func decode<T>(_ type: T.Type, from data: Data) throws -> T where T : Decodable
}

extension Encodable {
    func encode(with encoder: JSONEncoder = JSONEncoder()) throws -> Data {
        return try encoder.encode(self)
    }
}

extension Decodable {
    static func decode(with decoder: JSONDecoder = JSONDecoder(), from data: Data) throws -> Self {
        return try decoder.decode(Self.self, from: data)
    }
}

extension Encodable {
    func asDictionary(with encoder: JSONEncoder = JSONEncoder()) throws -> JSON {
        let data = try encoder.encode(self)
        guard let dictionary = try JSONSerialization.jsonObject(with: data, options: .allowFragments) as? [String: Any] else {
            throw encodeError.error
        }
        return dictionary
    }
}

extension Data {
    func toString() -> String{
        let dataString = String(data: self, encoding: String.Encoding.utf8)
        return dataString ?? ""
    }
}

enum encodeError: Error {
    case error
}

