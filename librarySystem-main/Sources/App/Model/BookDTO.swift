//
//  File.swift
//  
//
//  Created by Amani Almalki on 11/08/1445 AH.
//

import Foundation
import Foundation
import Fluent
import Vapor

struct BookDTO: Content {
    var id: UUID?
    var name: String
    var author: String
    var category: String
    var publisher: String
    var isBorrowed: Bool
    var customer: Customer.IDValue?
}

