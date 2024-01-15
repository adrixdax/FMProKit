//
//  File.swift
//
//
//  Created by Coderly Studio (Francesco De Marco, Gianluca Annina, Giuseppe Carannante) on 24/12/22.
//

import Foundation

public extension FMDataAPI {
    /// The is used in order to delete a single record of a specific table using its recordID
    /// - Parameters:
    ///   - table: The name of the table where is needed to delete the element
    ///   - id: The recordID of the record to delete
    /// - Throws: a CommonErrors.tableNameMissing error when the table parameter is empty
    /// - Throws: an HTTPError.errorCode_500_internalServerError error when using the wrong table name or when inserting wrong data inside the table
    func deleteRecord(table: String, recordID: Int) async throws -> Bool{
        guard !table.isEmpty else {
            throw FMProErrors.tableNameMissing
        }
        do {
            return try await executeRequest(url: "\(baseUri)/layouts/\(table)/records/\(recordID)", method: .delete).isEmpty
        } catch HTTPError.errorCode401Unauthorized {
            try await fetchToken()
            return try await deleteRecord(table: table, recordID: recordID)
        }
    }
    /// The is used in order to delete all the records of a specific table corresponding to "data" matching data on the database
    /// - Parameters:
    ///   - table: The name of the table where is needed to fetch the rows
    ///   - data: It contains the data considered as a generic matching database data
    /// - Throws: a CommonErrors.tableNameMissing error when the table parameter is empty
    /// - Throws: an HTTPError.errorCode_500_internalServerError error when using the wrong table name or when inserting wrong data inside the table
    func deleteRecord<T: Codable>(table: String, data: T) async throws -> Bool {
        if table.isEmpty {
            throw FMProErrors.tableNameMissing
        }
        let recordsToDelete = try await findRecordIds(table: table, data: data)
        var set : Set<Bool> = []
        for delete in recordsToDelete {
            do {
                set.insert(try await executeRequest(url: "\(baseUri)/layouts/\(table)/records/\(delete)", method: .delete).isEmpty)
            } catch HTTPError.errorCode401Unauthorized {
                try await fetchToken()
                set.insert(try await deleteRecord(table: table, data: data))
            }
        }
        return !set.contains(false)
    }
}
