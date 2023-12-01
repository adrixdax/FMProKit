//
//  FMODataAPI.swift
//  FMApi
//
//  Created by Coderly Studio (Francesco De Marco, Gianluca Annina, Giuseppe Carannante) on 05/10/22.
//

import Foundation
import SwiftUI

/// The class responsible to interface with the Filemaker Database using OData and API calls
public class FMODataAPI: APIProtocol {

    let hostname: String
    let database: String
    let baseUri: String
    var username: String
    var password: String
    var responseJSON = Data()
    var protocolVersion: ProtocolVersion
    var authData: String
    var request: URLRequest
    
    public required init(server: String, database: String, username: String, password: String, version: ProtocolVersion = .v4 ) {
        self.protocolVersion = version
        self.hostname = server
        self.database = database
        self.username = username
        self.password = password
        self.baseUri = "https://\(hostname)/fmi/odata/\(version.rawValue)/\(database)"
        self.request = URLRequest(url: URL(string: "https://")!)
        self.authData = "Basic \((username + ":" + password).data(using: .utf8)!.base64EncodedString())"
    }

        public func getRequest() -> URLRequest {
            return request
        }

        public func updateUsernameAndPassword(username: String, password: String) {
            self.authData = "Basic \(Data("\(username):\(password)".utf8).base64EncodedString())"
            self.request.addValue(self.authData, forHTTPHeaderField: "Authorization")
        }

        public func decodeJSONArray<T: Codable>(data: Data) throws -> [T] {
            return try JSONDecoder().decode(JSONValue<T>.self, from: data).value
        }
}
