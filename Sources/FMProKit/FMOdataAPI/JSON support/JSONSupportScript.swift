//
//  File.swift
//
//
//  Created by Coderly Studio (Francesco De Marco, Gianluca Annina, Giuseppe Carannante) on 05/12/22.
//

import Foundation

// MARK: - ScriptCaller
struct ScriptCaller<T: Codable>: Codable {
    var scriptParameterValue: T
}

// MARK: - ScriptResult
struct Scripter: Codable {
    var scriptResult: ScriptResult
}

// MARK: - ScriptResult
/// The result of the call of a script using API
/// The code indicates the status of the call
/// The resultParametere returns the value returned by the script if any
/// The message explains the error if any occured
public struct ScriptResult: Codable {
    public var code: Int?
    public var resultParameter: String?
    public var message: String?

    // MARK: - Initializers
    public init(code: Int?, resultParameter: String?, message: String?) {
        self.code = code
        self.resultParameter = resultParameter
        self.message = message
    }

    // MARK: - Getters and Setters
    /// Getter for `code` property.
    public var getCode: Int? {
        get {
            return code
        }
    }

    /// Setter for `code` property.
    public mutating func setCode(_ newValue: Int?) {
        code = newValue
    }

    /// Getter for `resultParameter` property.
    public var getResultParameter: String? {
        get {
            return resultParameter
        }
    }

    /// Setter for `resultParameter` property.
    public mutating func setResultParameter(_ newValue: String?) {
        resultParameter = newValue
    }

    /// Getter for `message` property.
    public var getMessage: String? {
        get {
            return message
        }
    }

    /// Setter for `message` property.
    public mutating func setMessage(_ newValue: String?) {
        message = newValue
    }
}
