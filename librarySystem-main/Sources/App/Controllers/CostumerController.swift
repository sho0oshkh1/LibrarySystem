//
//  File.swift
//
//
//  Created by SHUAA on 15.2.2024.
//

import Foundation
import Vapor

struct CostumerController : RouteCollection {
    func boot(routes: Vapor.RoutesBuilder) throws {
        
        let costumers = routes.grouped("customers")
        
        costumers.get(use: readCostumer)
        costumers.get( ":id", use: readCostumerById)

        costumers.post( use: createCostumer)
        costumers.put(":id", use: updateCostumer)
        costumers.delete(":id", use: deleteCostumer)
        
    }
  
    func readCostumer (req : Request) throws -> EventLoopFuture<[Customer]>{
        return Customer.query(on: req.db).all()
    }
    func readCostumerById (req : Request) throws -> EventLoopFuture<Customer>{
        guard let customerId = req.parameters.get("id"),
              let id = UUID(customerId)
        else{
            throw Abort(.badRequest,reason: "format not work!!")
        }
        return Customer.find(id, on: req.db)
            .unwrap(or: Abort(.notFound,reason:"customer not found"))
            .hop(to: req.eventLoop)
    }
    func createCostumer (req : Request)  throws -> EventLoopFuture<Customer> {
        let customer = try req.content.decode(Customer.self)
        return customer.save(on: req.db).map { customer }
    }
    func updateCostumer (req : Request)  throws -> EventLoopFuture<Customer>{
        let input  = try req.content.decode(Customer.self)
        return Customer.find(req.parameters.get("id"), on: req.db)
            .unwrap(or: Abort(.notFound))
            .flatMap{ customer in
                
                customer.name = input.name
                customer.phoneNum = input.phoneNum
                return customer.save(on: req.db).map{Customer(id:customer.id,name: customer.name, phoneNum: customer.phoneNum)}
                
            }
    }
    func deleteCostumer (req : Request)  throws -> EventLoopFuture<HTTPStatus> {
        return Customer.find(req.parameters.get("id"), on: req.db)
            .unwrap(or: Abort(.notFound))
            .flatMap {$0.delete (on: req.db)}
            .transform(to: .ok)
    }
    
//    func getCostumerById (req : Request)  throws -> String {
//        let id = req.parameters.get("id")!
//        return "get Costumer info with id >> \(id)"
//    }
    
}

