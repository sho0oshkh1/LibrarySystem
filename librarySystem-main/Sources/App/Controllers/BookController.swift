//
//  File.swift
//
//
//  Created by Amani Almalki on 05/08/1445 AH.
//

import Foundation
import Vapor
struct BookController : RouteCollection {
    func boot(routes: Vapor.RoutesBuilder) throws {
        let books = routes.grouped("books")
        books.get(use: readBook)
        books.get( ":bookId", use: readBookById)
        
        books.post(use: creatBook)
        
        books.delete(":bookId",use: deleteBook)
        
        books.put(":bookId",use: updateBook)
    }
    func readBook (req : Request)  throws -> EventLoopFuture<[Book]>{
        return Book.query(on: req.db).all()
    }
    func readBookById (req : Request) throws -> EventLoopFuture<Book>{
        guard let bookId = req.parameters.get("bookId"),
              let id = UUID(bookId)
        else{
            throw Abort(.badRequest,reason: "format not work!!")
        }
        return Book.find(id, on: req.db)
            .unwrap(or: Abort(.notFound,reason:"Book not found"))
            .hop(to: req.eventLoop)
    }
    
    
    func creatBook (req : Request) async throws -> Book {
        let bookData = try req.content.decode(BookDTO.self)
        
        
        let book = Book(name: bookData.name, author: bookData.author, category: bookData.category, publisher: bookData.publisher, isBorrowed: bookData.isBorrowed/*, customerID: bookData.customer*/)
        try await book.save(on: req.db)
        return book
    }
    //    func creatBook (req : Request) throws -> EventLoopFuture<Book> {
    //        let book = try req.content.decode(Book.self)
    //        return book.save(on: req.db).map { book }
    //    }
    //     we did an update
    func updateBook (req : Request) throws -> EventLoopFuture<Book> {
        let input  = try req.content.decode(BookDTO.self)
        return Book.find(req.parameters.get("bookId"), on: req.db)
        
        
            .unwrap(or: Abort(.notFound))
            .flatMap{book in
                book.name = input.name
                book.author = input.author
                book.category = input.category
                book.publisher = input.publisher
                book.isBorrowed = input.isBorrowed
                return book.save(on: req.db).map{Book(id:book.id,name: book.name, author: book.author, category: book.category, publisher: book.publisher, isBorrowed: book.isBorrowed)}
                
            }
    }
    func deleteBook (req : Request)  throws -> EventLoopFuture<HTTPStatus> {
        return Book.find(req.parameters.get("bookId"), on: req.db)
            .unwrap(or: Abort(.notFound))
            .flatMap {$0.delete (on: req.db)}
            .transform(to: .ok)
        
    }
    
}
