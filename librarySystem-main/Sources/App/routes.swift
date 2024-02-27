import Vapor

func routes(_ app: Application) throws {
    app.get { req  in
        return req.view.render("creatBook",["name": "hello vapor"])
        
    }

    app.get("hello") { req  -> String in
       return "Hello, world!"
    }
//    try app.register(collection: BookController())
}
