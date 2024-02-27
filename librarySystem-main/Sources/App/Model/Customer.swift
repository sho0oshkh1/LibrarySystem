//
//  File.swift
//
//
//  Created by Amani Almalki on 08/08/1445 AH.

import Foundation
import Fluent
import Vapor

final class Customer: Model, Content {
    // Name of the table or collection.
    static let schema = "customers"

    // Unique identifier.
    @ID(key: .id)
    var id: UUID?
    //
//    @Children(for: \.$customer)
//        var books: [Book]
    @Siblings(through: BorrowingBooks.self, from: \.$customer, to: \.$book)
    var books : [Book]
    // The customer's name.
    @Field(key: "name")
    var name: String
    @Field(key: "phoneNum")
    var phoneNum: String
    // Creates a new, empty .
    init() { }

    // Creates a new Customer with all properties set.
    init(id: UUID? = nil, name: String, phoneNum: String) {
        self.id = id
        self.name = name
        self.phoneNum = phoneNum
    }
}
