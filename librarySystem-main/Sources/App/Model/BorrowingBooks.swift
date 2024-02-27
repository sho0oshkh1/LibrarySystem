//
//  File.swift
//  
//
//  Created by SHUAA on 25.2.2024.
//
import Foundation
import Fluent
import Vapor


final class BorrowingBooks: Model, Content {
    // Name of the table or collection.
    static let schema = "borrowingbooks"

    // Unique identifier.
    @ID(key: .id)
    var id: UUID?
    
    @Field(key: "duration")
    var duration: String

    @Parent(key: "book_id")
       var book: Book

       @Parent(key: "customer_id")
       var customer: Customer


    // Creates a new, empty .
    init() { }

    // Creates a new Customer with all properties set.
    init(id: UUID? = nil, bookId: UUID, customerId: UUID,duration:String) {
        self.id = id
        self.duration = duration
        self.$book.id =  bookId
        self.$customer.id =  customerId
    }
}
