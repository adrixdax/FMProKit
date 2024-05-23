//
//  File.swift
//  
//
//  Created by Adriano d'Alessandro on 13/12/23.
//

import Foundation

/// A function to decode a JSON array from Data to an array of Codable objects.
///
/// - Parameter data: The JSON data to decode.
/// - Returns: An array of decoded objects of type `T`.
/// - Throws: An error if the decoding process fails.
public func decodeJSONArray<T: Codable>(from data: Data) throws -> [T] {
    let decoder = JSONDecoder()
    
    // First, try to decode the data as an array of `T`
    if let array = try? decoder.decode([T].self, from: data) {
        return array
    }
    
    // If the data is not an array, try to decode it as a single `T` object
    if let singleObject = try? decoder.decode(T.self, from: data) {
        return [singleObject]
    }
    
    // If both attempts fail, throw a decoding error
    throw DecodingError.dataCorrupted(.init(codingPath: [], debugDescription: "Data could not be decoded as either an array or a single object of type \(T.self)."))
}
