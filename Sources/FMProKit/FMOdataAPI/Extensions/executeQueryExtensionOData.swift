//
//  File.swift
//
//
//  Created by Coderly Studio (Francesco De Marco, Gianluca Annina, Giuseppe Carannante) on 23/12/22.
//

import SwiftUI

public extension FMODataAPI {
    /// Execute a generic Delete query
    /// - Parameter query: An OData query used to filter the API call
    func executeQueryDelete(query: String) async throws -> Bool{
        return try await executeRequest(url: "\(baseUri)/\(query)", method: .delete).isEmpty
    }

    /// Execute a generic Get query
    /// - Parameter query: An OData query used to filter the API call
    /// - Returns: An array of Model type after fetching all the data
    func executeQueryGet<T: Codable>(query: String) async throws -> [T] {
        do{
            return try decodeJSONArray(from: try await executeRequest(url: "\(baseUri)/\(query)", method: .get))
        } catch {
            print(error.localizedDescription)
        }
        return []
    }
    
    /// Execute a generic Patch query
    /// - Parameters:
    ///   - query: An OData query used to filter the API call
    ///   - record: the record of model T type with all the changes
    func executeQueryPatch<T: Codable>(query: String, data: T) async throws -> [T]{
        return try decodeJSONArray(from: try await executeRequest(url: "\(baseUri)/\(query)", method: .patch, data: data))
    }
 
    /// Execute a generic Post query
    /// - Parameters:
    ///   - query: An OData query used to filter the API call
    ///   - data: It contains the data considered as a generic
    func executeQueryPost<T: Codable>(query: String, data: T) async throws -> [T]{
        return try decodeJSONArray(from: try await executeRequest(url: "\(baseUri)/\(query)", method: .post, data: data))
    }
}
