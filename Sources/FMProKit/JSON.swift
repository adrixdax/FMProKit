//
//  File.swift
//  
//
//  Created by Adriano d'Alessandro on 13/12/23.
//

import Foundation

public func decodeJSONArray<T: Codable>(data: Data) throws -> [T] {
    do {
        return try JSONDecoder().decode(JSONValue<T>.self, from: data).value
    } catch {
        return Array(arrayLiteral: try JSONDecoder().decode(T.self, from: data))
    }
}
