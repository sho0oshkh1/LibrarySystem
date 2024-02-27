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

struct CreateBook: AsyncMigration {
    // Prepares the database for storing books models.
    func prepare(on database: Database) async throws {
        try await database.schema("books")
            .id()
            .field("name", .string)
            .field("author", .string)
            .field("category", .string)
            .field("publisher", .string)
            .field("isBorrowed", .bool)
            .field("customer_id", .uuid, .references("customers", "id"))
            .create()
    }

    // Optionally reverts the changes made in the prepare method.
    func revert(on database: Database) async throws {
        try await database.schema("books").delete()
    }
}

