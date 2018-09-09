import Vapor

public func routes(_ router: Router) throws {

    router.get("api", "name") { req -> String in
        let namesArray = ["Chris", "Sarah", "Bob", "Jess"]
        let number = Int(arc4random_uniform(4))
        return "Hello, \(namesArray[number])"
    }

    router.get("api", "first_name", String.parameter, "last_name", String.parameter) { req -> String in
        let firstName = try req.parameters.next(String.self)
        let lastName = try req.parameters.next(String.self)
        return "Your name is \(firstName) \(lastName)"
    }

    router.post(Person.self, at: "api/name") { req, data -> String in
        return "Hello \(data.firstName) \(data.lastName ?? "")"
    }

//    router.post(Person.self, at: "api/name") { req, data -> Person in
//        return data
//    }
}

struct Person: Content {
    let firstName: String
    let lastName: String?
}
