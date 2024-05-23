//
//  FMODataAPI.swift
//  FMApi
//
//  Created by Coderly Studio (Francesco De Marco, Gianluca Annina, Giuseppe Carannante) on 05/10/22.
//
import Foundation
import SwiftUI

public class FMODataAPI: APIProtocol {
    
    /// The hostname of the FileMaker server.
    public let hostname: String
    
    /// The name of the database.
    public let database: String
    
    /// The base URI for the API requests.
    public let baseUri: String
    
    /// The username for authentication.
    public var username: String
    
    /// The password for authentication.
    public var password: String
    
    /// The protocol version for the OData API.
    public var protocolVersion: ProtocolVersion
    
    /// The base64 encoded authentication data.
    public var authData: String
    
    /// The URL request used for API calls.
    public var request: URLRequest
    
    /// The HTTP response data in JSON format.
    public var responseJSON: Data = Data()
    
    /// Initializes a new instance of `FMODataAPI`.
    ///
    /// - Parameters:
    ///   - server: The hostname of the FileMaker server.
    ///   - database: The name of the database.
    ///   - username: The username for authentication.
    ///   - password: The password for authentication.
    ///   - version: The protocol version for the OData API. Default is `.v4`.
    public required init(server: String, database: String, username: String, password: String, version: ProtocolVersion = .v4) {
        self.protocolVersion = version
        self.hostname = server
        self.database = database
        self.username = username
        self.password = password
        self.baseUri = "https://\(hostname)/fmi/odata/\(version.rawValue)/\(database)"
        self.request = URLRequest(url: URL(string: baseUri)!)
        self.authData = "Basic \((username + ":" + password).data(using: .utf8)!.base64EncodedString())"
    }
    
    /// Returns the current URL request.
    ///
    /// - Returns: The current `URLRequest` object.
    public func getRequest() -> URLRequest {
        return request
    }
    
    /// Updates the username and password for authentication.
    ///
    /// - Parameters:
    ///   - username: The new username.
    ///   - password: The new password.
    public func updateUsernameAndPassword(username: String, password: String) {
        self.authData = "Basic \(Data("\(username):\(password)".utf8).base64EncodedString())"
        self.request.addValue(self.authData, forHTTPHeaderField: "Authorization")
    }
}
