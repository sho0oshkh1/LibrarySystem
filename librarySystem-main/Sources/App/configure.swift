import Vapor
import Fluent
import FluentPostgresDriver

// configures your application
public func configure(_ app: Application) async throws {
    // uncomment to serve files from /Public folder
    // app.middleware.use(FileMiddleware(publicDirectory: app.directory.publicDirectory))

    // register routes
    app.databases.use(.postgres(configuration:SQLPostgresConfiguration(hostname: "localhost", username: "postgres", password: "", database: "librarysystem",
        tls: .prefer(try .init(configuration: .clientDefault)))), as: .psql)
    
    try app.register(collection: CostumerController())
    try app.register(collection: BookController())
     try app.register(collection: BorrowingController())

    try routes(app)
    

    app.migrations.add(CreateCustomer())
    app.migrations.add(CreateBook())
      app.migrations.add(CreateBorrwingBook())

    
}
