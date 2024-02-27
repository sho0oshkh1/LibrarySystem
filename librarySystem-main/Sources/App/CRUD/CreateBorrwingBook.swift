//
//  File.swift
//
//
//  Created by SHUAA on 25.2.2024.
//

import Foundation
import Fluent
import FluentPostgresDriver
import Vapor


struct CreateBorrwingBook: AsyncMigration {
    // Prepares the database for storing customers models.
    func prepare(on database: Database) async throws {
        try await database.schema("borrowingbooks")
            .id()
                    .field("customer_id", .uuid, .references("customers", "id"))
                    .field("book_id", .uuid, .references("books", "id"))
                    .field("duration", .string)


            .create()
    }

    // Optionally reverts the changes made in the prepare method.
    func revert(on database: Database) async throws {
        try await database.schema("borrowingbooks").delete()
    }
}
