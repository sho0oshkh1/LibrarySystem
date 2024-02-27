//
//  File.swift
//
//
//  Created by Amani Almalki on 08/08/1445 AH.
//

import Foundation
import Fluent
import FluentPostgresDriver
import Vapor

struct CreateCustomer: AsyncMigration {
    // Prepares the database for storing customers models.
    func prepare(on database: Database) async throws {
        try await database.schema("customers")
            .id()
            .field("name", .string)
            .field("phoneNum", .string)
            
            .create()
    }

    // Optionally reverts the changes made in the prepare method.
    func revert(on database: Database) async throws {
        try await database.schema("customers").delete()
    }
}
