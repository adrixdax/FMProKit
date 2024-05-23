//
//  FMDataAPI.swift
//  FilemakerAPI
//
//  Created by Coderly Studio (Francesco De Marco, Gianluca Annina, Giuseppe Carannante) on 06/10/22.
//

import Foundation

/// A class responsible for interfacing with the FileMaker Database using OData and API calls.
public class FMDataAPI: APIProtocol {
    
    /// The hostname of the FileMaker server.
    public let hostname: String
    
    /// The name of the database.
    public let database: String
    
    /// The base URI for API requests.
    public let baseUri: String
    
    /// The username for authentication.
    public var username: String
    
    /// The password for authentication.
    public var password: String
    
    /// The database credentials in the format "USERNAME:PASSWORD".
    public var authData: String
    
    /// The token that FileMaker generates to use the Data APIs.
    public var bearerToken: String
    
    /// The URL request used for API calls.
    public var request: URLRequest
    
    /// The HTTP response data in JSON format.
    public var responseJSON = Data()
    
    /// The version of the protocol to use.
    public var protocolVersion: ProtocolVersion
    
    /// Initializes a new instance of `FMDataAPI`.
    ///
    /// - Parameters:
    ///   - server: The hostname of the FileMaker server.
    ///   - database: The name of the database.
    ///   - username: The username for authentication.
    ///   - password: The password for authentication.
    ///   - version: The protocol version. Default is `.vLatest`.
    public required init(server: String, database: String, username: String, password: String, version: ProtocolVersion = .vLatest) {
        self.hostname = server
        self.database = database
        self.username = username
        self.password = password
        self.protocolVersion = version
        self.authData = ""
        self.baseUri = "https://\(hostname)/fmi/data/\(version.rawValue)/databases/\(database)"
        self.bearerToken = ""
        self.request = URLRequest(url: URL(string: baseUri)!)
        self.request.setValue("Basic \(authData)", forHTTPHeaderField: "Authorization")
    }
  
    /// Retrieves the access token to the database.
    public func fetchToken() async throws {
        // Implementation goes here
    }

    /// Returns the last URLRequest used.
    ///
    /// - Returns: The last URLRequest object.
    public func getRequest() -> URLRequest {
        return request
    }

    /// Updates the username and password for authentication.
    ///
    /// - Parameters:
    ///   - username: The new username.
    ///   - password: The new password.
    public func updateUsernameAndPassword(username: String, password: String) async throws {
        // Implementation goes here
    }
    
    /// Returns the last response in JSON format.
    ///
    /// - Returns: The response data in JSON format.
    public func getResponseJSON() -> Data {
        return responseJSON
    }
}
