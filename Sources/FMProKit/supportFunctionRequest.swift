//
//  File.swift
//
//
//  Created by Coderly Studio (Francesco De Marco, Gianluca Annina, Giuseppe Carannante) on 23/12/22.
//

import SwiftUI

extension APIProtocol {
    
    
    func createRequest(url: String, method: HTTPMethod) async throws {
        guard let requestURL = URL(string: url.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? "") else {
            throw URLError(.badURL)
        }
        var request = URLRequest(url: requestURL)
        request.addValue(authData, forHTTPHeaderField: "Authorization")
        request.httpMethod = method.rawValue
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        self.request = request
    }
    
    
    
    
    /// Build and execute an HTTPRequest fetching data
    /// - Parameters:
    ///   - url: The final URL as a String
    ///   - method: The HTTP method
    /// - Returns: The fetched data
    func executeRequest(url: String, method: HTTPMethod) async throws -> Data {
        do {
            try await createRequest(url: url, method: method)
        } catch {
            print(error.localizedDescription)
        }
        let (data, response) = try await URLSession.shared.data(for: request)
        responseJSON = data
        try (response as? HTTPURLResponse)?.checkResponseCode()
        return data
    }

    /// Build and execute an HTTPRequest sending JSON data and fetching a response
    /// - Parameters:
    ///   - url: The final URL as a String
    ///   - method: The HTTP method
    ///   - data: The data to be sent as JSON
    /// - Returns: The fetched data
    func executeRequest<T: Codable>(url: String, method: HTTPMethod, data: T) async throws -> Data {
        do {
            try await createRequest(url: url, method: method)
        } catch {
            print(error.localizedDescription)
        }
        let encoded = try JSONEncoder().encode(data)
        let (responseData, response) = try await URLSession.shared.upload(for: request, from: encoded)
        responseJSON = responseData
        try (response as? HTTPURLResponse)?.checkResponseCode()
        return responseData
    }
}
