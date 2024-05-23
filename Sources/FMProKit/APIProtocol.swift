//
//  File.swift
//
//
//  Created by Coderly Studio (Francesco De Marco, Gianluca Annina, Giuseppe Carannante) on 29/11/22.
//

import Foundation
import Combine

/// This protocol defines the structure and function signatures for an API client.
protocol APIProtocol: ObservableObject {
    /// The server domain.
    var hostname: String { get }
    
    /// The name of the database.
    var database: String { get }
    
    /// The base URI for API requests.
    var baseUri: String { get }
    
    /// The username credential to access the database.
    var username: String { get }
    
    /// The password credential to access the database.
    var password: String { get }
    
    /// The HTTP response data in JSON format.
    var responseJSON: Data { get set }
    
    /// The protocol version used for API requests.
    var protocolVersion: ProtocolVersion { get set }
    
    /// The authorization data for HTTP requests.
    var authData: String { get set }
    
    /// The last sent request.
    var request: URLRequest { get set }
    
    /// Initializes a new API client.
    ///
    /// - Parameters:
    ///   - server: The server domain.
    ///   - database: The name of the database.
    ///   - username: The username credential.
    ///   - password: The password credential.
    ///   - version: The protocol version.
    init(server: String, database: String, username: String, password: String, version: ProtocolVersion)
}
