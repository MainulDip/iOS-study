// first class citizen and adopts many traditional class features
// supports computedProperties, instance methods, init, supports inheritance and protocol conformation 
// values defined in enum's are called its `enumeration case` (defined by case keyword)
// enumeration case can have it own constructor
// if type is already known (variable initialization), type can be dropped in the subsequent use.
// like `.result` and `.failure` are dropping `ServerResponse` type 

enum ServerResponse {
    case result(String, String)
    case failure(String)
}

let success = ServerResponse.result("6:00 am", "8:09 pm")
let failure = ServerResponse.failure("Out of cheese.")

// the matching enum instance will call the matching switch case
// because success and failure's type is already known, the type can be dropped
switch success {
case let .result(sunrise, sunset): //same as ServerResponse.result(...)
    print("Sunrise is at \(sunrise) and sunset is at \(sunset).") // called
case let .failure(message):
    print("Failure...  \(message)")
}
// Prints "Sunrise is at 6:00 am and sunset is at 8:09 pm."

switch failure {
case let .result(sunrise, sunset):
    print("Sunrise is at \(sunrise) and sunset is at \(sunset).")
case let .failure(message):
    print("Failure...  \(message)") // called
}

// Sunrise is at 6:00 am and sunset is at 8:09 pm.
// Failure...  Out of cheese.