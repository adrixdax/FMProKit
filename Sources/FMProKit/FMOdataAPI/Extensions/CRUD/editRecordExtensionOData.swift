//
//  File.swift
//
//
//  Created by Coderly Studio (Francesco De Marco, Gianluca Annina, Giuseppe Carannante) on 23/12/22.
//

import SwiftUI

public extension FMODataAPI {
    /// Edit a record inside the specified table using its id
    /// - Parameters:
    ///   - record: the record of model T type with all the new data
    ///   - table: The name of the table in wich perform the action
    ///   - id: The Primary key (PK) of the searched record
    /// - Throws: an HTTPError.errorCode_404_notFound error when using the wrong table name or the record is missing
    /// - Throws: an HTTPError.errorCode_400_badRequest error when using the wrong data, or model, to update the table
    /// - Throws: a FMProErrors.tableNameMissing error when the table parameter is empty
    /// - Attention: This function is for Text id and not for the Number ones
    func editRecord<T: Codable>(table: String, id: String, data: T) async throws -> [T] {
        guard !table.isEmpty else {
            throw FMProErrors.tableNameMissing
        }
        let urlTmp = "\(baseUri)/\(table)('\(id)')"
        return try decodeJSONArray(data: try await executeRequest(url: urlTmp, method: .patch, data: data))
    }
    
    /// Edit a record inside the specified table using its id
    /// - Parameters:
    ///   - record: the record of model T type with all the new data
    ///   - table: The name of the table in wich perform the action
    ///   - id: The Primary key (PK) of the searched record
    /// - Throws: an HTTPError.errorCode_404_notFound error when using the wrong table name or the record is missing
    /// - Throws: an HTTPError.errorCode_400_badRequest error when using the wrong data, or model, to update the table
    /// - Throws: a FMProErrors.tableNameMissing error when the table parameter is empty
    /// - Attention: This function is for Text id and not for the Number ones
    func editRecord<T: Codable>(table: String, id: UUID, data: T) async throws -> [T]{
        return try await editRecord(table: table, id: id.uuidString, data: T.self as! T)
    }

    /// Edit a record inside the specified table using its id
    /// - Parameters:
    ///   - record: the record of model T type with all the new data
    ///   - table: The name of the table in wich perform the action
    ///   - id: The Primary key (PK) of the searched record
    /// - Throws: an HTTPError.errorCode_404_notFound error when using the wrong table name or the record is missing
    /// - Throws: an HTTPError.errorCode_400_badRequest error when using the wrong data, or model, to update the table
    /// - Throws: a FMProErrors.tableNameMissing error when the table parameter is empty
    func editRecord<T: Codable>(table: String, id: Int, data: T) async throws -> [T] {
        return try await editRecord(table: table, id: String(id), data: T.self as! T)
    }
    
    /// Edit all the records inside the specified table matching a query
    /// - Parameters:
    ///   - record: the record of model T type with all the new data
    ///   - table: The name of the table in wich perform the action
    ///   - query: An OData query used to filter the API call
    /// - Throws: an HTTPError.errorCode_400_badRequest error when the apex are not used correctly or in general the query is not correct
    /// - Throws: an HTTPError.errorCode_404_notFound error when the table name is not correct
    /// - Throws: a FMProErrors.tableNameMissing error when the table parameter is empty
    /// - Attention: the _?_ after the table name is already inserted
    /// - Attention: when inserting a filter clause write it this way: “$filter= conditions” Specify that condition should be defined this way: “searchedField confrontationOperator value”
    /// - Attention: value is ‘value’ in case of a Text meanwhile value in case of a Number
    func editRecordUsingQuery<T: Codable>(table: String, query: String, data: T) async throws -> [T] {
        guard !table.isEmpty else {
            throw FMProErrors.tableNameMissing
        }
        let urlTmp = "\(baseUri)/\(table)?\(query)"
        return try decodeJSONArray(data: try await executeRequest(url: urlTmp, method: .patch, data: data))
    }
    
    /// Edit all the records inside the specified table matching a filter query
    /// - Parameters:
    ///   - record: the record of model T type with all the new data
    ///   - table: The name of the table in wich perform the action
    ///   - query: An OData query used to filter the API call
    ///   - field: The field used to filter the table
    ///   - value: The value of the field that need to match in the query
    ///   - filterOption: The filter option for the query
    /// - Throws: an HTTPError.errorCode_400_badRequest error when the apex are not used correctly or in general the query is not correct, the name of the field is not correct or missing
    /// - Throws: an HTTPError.errorCode_404_notFound error when The name of the table in wich perform the action is wrong
    /// - Throws: a FMProErrors.tableNameMissing error when the table parameter is empty
    /// - Throws: a FMProErrors.fieldNameMissing error when the field parameter is empty
    func editRecord<T: Codable, U>(table: String, field: String, filterOption: FilterOption, value: U, data: T) async throws -> [T] {
        guard !table.isEmpty else {
            throw FMProErrors.tableNameMissing
        }
        guard !field.isEmpty else {
            throw FMProErrors.fieldNameMissing
        }
        var urlTmp = ""
        if var _ = value as? String {
            urlTmp = "\(baseUri)/\(table)?$filter= \(field) \(filterOption.rawValue) '\(value)'"
        } else {
            urlTmp = "\(baseUri)/\(table)?$filter= \(field) \(filterOption.rawValue) \(value)"
        }
        return try decodeJSONArray(data: try await executeRequest(url: urlTmp, method: .patch, data: data))
    }
}
