import Vapor

public func routes(_ router: Router) throws {

    router.get("api", "name") { req -> String in
        let namesArray = ["Chris", "Sarah", "Bob", "Jess"]
        let number = getRandomNumber(0, 3)
        return "Hello, \(namesArray[number])"
    }

    func getRandomNumber(_ min: Int, _ max: Int) -> Int {
        #if os(Linux)
        return Int(random() % max) + min
        #else
        return Int(arc4random_uniform(UInt32(max)) + UInt32(min))
        #endif
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
