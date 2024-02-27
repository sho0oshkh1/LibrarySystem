//
//  File.swift
//
//
//  Created by SHUAA on 25.2.2024.
//

import Foundation
import Vapor

struct BorrowingController : RouteCollection {
    
    func boot(routes: Vapor.RoutesBuilder) throws {
        
        let borrowingbooks = routes.grouped("borrowingbooks")
        
        borrowingbooks.get(use: readBorrowingBooks)
       borrowingbooks.post( use: createBorrowingBooks)
//        borrowingbooks.put(":id", use: updateBorrowingBooks)
        borrowingbooks.delete(":id", use: deleteBorrowingBooks)
        
    }
    
    func readBorrowingBooks (req : Request) throws -> EventLoopFuture<[BorrowingBooks]>{
        return BorrowingBooks.query(on: req.db).all()
    }
    
    
    
        func createBorrowingBooks (req : Request)  async throws -> BorrowingBooks {
            let borrowingbooks = try req.content.decode(BorrowingBooks.self)
            
            //find book
            
            guard let book = try await Book.find(borrowingbooks.$book.id, on: req.db)
                    else
            {
                throw Abort(.notFound)
            }
            
         
            
            guard let customr = try await Customer.find(borrowingbooks.$customer.id, on: req.db)
                    else
            {
                throw Abort(.notFound)
            }
            try await borrowingbooks.save(on: req.db)
            
            book.isBorrowed = true
            
            try await book.save(on: req.db)
            
            
            //find customer
            
            
            return borrowingbooks
        }
    
    
    func deleteBorrowingBooks (req : Request)  async throws -> BorrowingBooks {
        guard let borrowingId = req.parameters.get("id") else {
            throw Abort(.notFound)
        }
        
        let uuid = UUID(uuidString: borrowingId)

        guard let borrowingbook = try await BorrowingBooks.find(uuid, on: req.db)
                else
        {
            throw Abort(.notFound)
        }
        guard let book = try await Book.find(borrowingbook.$book.id, on: req.db)
                else
        {
            throw Abort(.notFound)
        }
        book.isBorrowed = false
        try await book.save(on: req.db)
        
        try await  borrowingbook.delete(on: req.db)
        
         
        return borrowingbook
    }
    
    
    //    func readBorrowingBooksById (req : Request) throws -> EventLoopFuture<BorrowingBooks>{
    //        guard let borrowingId = req.parameters.get("id"),
    //              let id = UUID(borrowingId)
    //        else{
    //            throw Abort(.badRequest,reason: "format not work!!")
    //        }
    //        return BorrowingBooks.find(id, on: req.db)
    //            .unwrap(or: Abort(.notFound,reason:"BorrowingBooks not found"))
    //            .hop(to: req.eventLoop)
    //    }
    //    func createBorrowingBooks (req : Request)  throws -> EventLoopFuture<BorrowingBooks> {
    //        let borrowingbooks = try req.content.decode(BorrowingBooks.self)
    //        return borrowingbooks.save(on: req.db).map { borrowingbooks }
    //    }
    //    func updateBorrowingBooks (req : Request)  throws -> EventLoopFuture<BorrowingBooks>{
    //        let input  = try req.content.decode(BorrowingBooks.self)
    //        return BorrowingBooks.find(req.parameters.get("id"), on: req.db)
    //            .unwrap(or: Abort(.notFound))
    //            .flatMap{ borrowingbooks in
    //
    //
    //                return borrowingbooks.save(on: req.db).map{BorrowingBooks()}
    //
    //            }
    //    }
//        func deleteBorrowingBooks (req : Request)  throws -> EventLoopFuture<HTTPStatus> {
//            return BorrowingBooks.find(req.parameters.get("id"), on: req.db)
//                .unwrap(or: Abort(.notFound))
//                .flatMap {$0.delete (on: req.db)}
//                .transform(to: .ok)
//        }
    //
    //}
    
    
}
