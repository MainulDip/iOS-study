// first class citizen and adopts many traditional class features
// supports computedProperties, instance methods, init, supports inheritance and protocol conformation
// values defined in enum's are called its `enumeration case` (defined by case keyword)
// enumeration case can have it's own constructor
// if type is already known (variable initialization), type can be dropped in the subsequent use.
// like `.result` and `.failure` are dropping `ServerResponse` type

// the matching enum instance will call the matching switch case
// because success and failure's type is already known, the type can be dropped

// Prints "Sunrise is at 6:00 am and sunset is at 8:09 pm."

// Sunrise is at 6:00 am and sunset is at 8:09 pm.
// Failure...  Out of cheese.

enum ServerResponse {
    case result(String, String)
    case failure(String)
}
let success = ServerResponse.result("6:00 am", "8:09 pm")
let failure = ServerResponse.failure("Out of cheese.")
switch success {
case let .result(sunrise, sunset):  //same as ServerResponse.result(...)
    print("Sunrise is at \(sunrise) and sunset is at \(sunset).")  // called
case let .failure(message):
    print("Failure...  \(message)")
}
switch failure {
case let .result(sunrise, sunset):
    print("Sunrise is at \(sunrise) and sunset is at \(sunset).")
case let .failure(message):
    print("Failure...  \(message)")  // called
}
print("\n\n---------- enum with attached value -----------\n\n")
enum EqOperatorAssociated {
    case add(_ val: String = "+")
    case subtract(_ val: String = "-")
    case multiply(_ val: String = "x")
    case divide(_ val: String = "/")
}
func calculate(type: EqOperatorAssociated, lhs: Double, rhs: Double) -> Double {
    let result = switch type {
    
    case .add(_):
        lhs + rhs
    case .subtract(_):
        lhs - rhs
    case .multiply(_):
        lhs * rhs
    case .divide(_):
        lhs / rhs
    }

    return result
}

let onePlusOne = calculate(type: .add(), lhs: 1, rhs: 1)
func abc() {
    guard case EqOperatorAssociated.add(let val) else { return }
} 
print("\(EqOperatorAssociated.add())")


enum EqOperatorRawVal: String {
    case add = "+"
    case subtract = "-"
    case multiply = "x"
    case divide = "/"
}

func calculate2(type: EqOperatorRawVal, lhs: Double, rhs: Double) -> Double {
    let result = switch type {
    
    case .add:
        lhs + rhs
    case .subtract:
        lhs - rhs
    case .multiply:
        lhs * rhs
    case .divide:
        lhs / rhs
    }

    return result
}






let twoPlusTwo = calculate2(type: .add, lhs: 2, rhs: 2)
print("rawValue = \(EqOperatorRawVal.add.rawValue) and twoPlusTwo = \(twoPlusTwo)")