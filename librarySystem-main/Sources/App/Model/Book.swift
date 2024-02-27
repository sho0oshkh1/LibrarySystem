//
//  File.swift
//
//
//  Created by Amani Almalki on 08/08/1445 AH.
//

import Foundation
import Fluent
import Vapor

final class Book: Model , Content {
    // Name of the table or collection.
    static let schema = "books"

    // Unique identifier.
    @ID(key: .id)
    var id: UUID?
//    // (one-to-many)
//        @OptionalParent(key: "customer_id")
//    var customer: Customer?
    @Siblings(through: BorrowingBooks.self, from: \.$book, to: \.$customer)
    var customers : [Customer]
    // The customer's name.
    @Field(key: "name")
    var name: String
    @Field(key: "author")
    var author: String
    @Field(key: "category")
    var category: String
    @Field(key: "publisher")
    var publisher: String
    @Field(key: "isBorrowed")
    var isBorrowed: Bool
    // Creates a new, empty init .
    init() { }

    // Creates a new Book with all properties set.

    init(id: UUID? = nil, name: String, author: String, category:String, publisher: String, isBorrowed: Bool = false, customerID: UUID? = nil) {
        self.id = id
        self.name = name
        self.author = author
        self.category = category
        self.publisher = publisher
        self.isBorrowed = isBorrowed
//        self.$customer.id = customerID
      
    }
}
