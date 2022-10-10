class NamedShape {
    var numberOfSides: Int = 0
    var name: String

    init(name: String) {
        // print("New NamedShape Instance Init")
        self.name = name
    }

    func simpleDescription() -> String {
        return "A shape with \(numberOfSides) sides."
    }

    deinit {
        print("Do some cleanup when deallocated")
    }
}
// to utilize deinit, class instantiation should be keept inside optional variable. If deinitialization is not necessary, then could be referenced with regular variable like -> var shape = NameeShape(name: "SomeNames")
var shape: NamedShape? = NamedShape(name : "Some Names")
shape?.numberOfSides = 7

print("shape.name : \(shape!.name)")
print("shape.numberOfSides : \(shape!.numberOfSides)")
print("shape.simpleDescription() : \(shape!.simpleDescription())")
shape = nil
print("\nbasic-class---------------Ends----------------\n")

/*
* Inheritance / Sub Class / Super Class
* Implement Super Classes' Initializer with "super.init()"
*/
print("\ninheritance/sub/super-Class---------------Starts----------------\n")
class Square: NamedShape {
    var sideLength: Double

    init(sideLength: Double, name: String) {
        self.sideLength = sideLength
        super.init(name: name)
        numberOfSides = 4 // Setting Super Classes' Property
    }

    func area() -> Double {
        return sideLength * sideLength
    }

    override func simpleDescription() -> String {
        return "A square with sides of length \(sideLength)."
    }
}
let test = Square(sideLength: 5.2, name: "my test square")
print("test.area(): \(test.area())")

print("test.simpleDescription(): \(test.simpleDescription())")

test.numberOfSides = 7 // Accessing Super Classes's Property
print("test.numberOfSides : \(test.numberOfSides)")
print("\ninheritance/sub/super-Class---------------Ends----------------\n")

/*
* Getters & Setters
* set get the parameter newValue or custom parameter can also be set
*/
print("\nget/set---------------Starts----------------\n")
class TwelveOrLess {
    private var number = 0
    var filteredNumber: Int {
        get { return number }
        set { number = min(newValue, 12) }
        // In the setter for perimeter, the new value has the implicit name newValue. You can provide an explicit name in parentheses after set.
        // like // set (someval) {number = min(someval, 12)}
        // willSet and didSet cannot work get/set at the same property
        // willSet {
        //     print("willSet calling from TwelveOrLess : newValue is \(newValue)")
        // }

        // didSet {
        //     print("didSet calling from TwelveOrLess : oldValue is \(oldValue)")
        // }
    }

    init(number: Int = 7){
        self.filteredNumber = number
    }
}

var tol = TwelveOrLess(number: 24)
print(tol.filteredNumber) // 12
tol.filteredNumber = 4
print(tol.filteredNumber)
var tolD = TwelveOrLess()
print(tolD.filteredNumber)
print("\nget/set---------------Ends----------------\n")

/*
* willset and didset method to run before and after setting new values to class properties
* get/set and willSet/didSet will not work at the same time, use either couple
*/
print("\nwillSet/didSet---------------Starts----------------\n")

class EquilateralTriangle: NamedShape {
    var sideLength: Double = 0.0

    init(sideLength: Double, name: String) {
        self.sideLength = sideLength
        super.init(name: name)
        numberOfSides = 3
    }

    var perimeter: Double {
        get {
            return 3.0 * sideLength
        }
        set {
            sideLength = newValue / 3.0
        }
    }

    override func simpleDescription() -> String {
        return "An equilateral triangle with sides of length \(sideLength)."
    }

    deinit {
        print("EquilateralTirangle Deallocation")
    }
}

    class TriangleAndSquare {
        /*
        * When triangle setter will call, it will also update square with same value and vice-versa
        */
        var triangle: EquilateralTriangle {
            willSet {
                square.sideLength = newValue.sideLength
            }
        }
        var square: Square {
            didSet {
                print("didSet calling: setting square which will also update triangle's sidelength and the oldValue : \(oldValue)")
            }
            willSet {
                print("willSet calling: setting same sidelength for triangle and the newValue : \(newValue)")
                triangle.sideLength = newValue.sideLength
            }
        }
        init(size: Double, name: String) {
            self.square = Square(sideLength: size, name: name)
            triangle = EquilateralTriangle(sideLength: size, name: name)
        }
    }
    var triangleAndSquare = TriangleAndSquare(size: 10, name: "another test shape")
    print("triangleAndSquare.square.sideLength : \(triangleAndSquare.square.sideLength)")
    // Prints "10.0"
    print("triangleAndSquare.triangle.sideLength : \(triangleAndSquare.triangle.sideLength)")
    // Prints "10.0"

    // also setting a new instance will call the old instance's deinit for "no reference" cause
    triangleAndSquare.square = Square(sideLength: 50, name: "larger square")
    print("triangleAndSquare.triangle.sideLength : \(triangleAndSquare.triangle.sideLength)")
    // Prints "50.0"

    print("\nwillSet/didSet---------------Ends----------------\n")

    /*
    * Enumerations
    * should be in CamelCase and Singular
    */
print("\nEnumerations/enum---------------Starts----------------\n")

enum Suit {
    case spades, hearts, diamonds, clubs

    func simpleDescription() -> String {
        switch self {
        case .spades:
            return "spades"
        case .hearts:
            return "hearts"
        case .diamonds:
            return "diamonds"
        case .clubs:
            return "clubs"
        }
    }
}
let hearts = Suit.hearts
let heartsDescription = hearts.simpleDescription()
print("heartsDescription : \(heartsDescription)")


print("\nEnumerations/enum---------------Example 2----------------\n")

enum ServerResponse {
    case result(String, String)
    case failure(String)
}

let success = ServerResponse.result("6:00 am", "8:09 pm")
let failure = ServerResponse.failure("Out of cheese.")

switch success {
case let .result(sunrise, sunset):
    print("Sunrise is at \(sunrise) and sunset is at \(sunset).")
case let .failure(message):
    print("Failure...  \(message)")
}

switch failure {
case let .result(sunrise, sunset):
    print("Sunrise is at \(sunrise) and sunset is at \(sunset).")
case let .failure(message):
    print("Failure...  \(message)")
}


print("\nEnumerations/enum---------------Example 3----------------\n")

enum Rank: Int { // rawValue is only available to Int
    case test = 77
    case ace = 1
    case two, three, four, five, six, seven, eight, nine, ten
    case jack, queen, king

    func simpleDescription() -> String {
        switch self {
        case .ace:
            return "Printing ace"
        case .jack:
            return "Printing jack"
        case .queen:
            return "Printing queen"
        case .king:
            return "Printing king"
        default:
            return "Giving Back Default Case, and the enum name and rawValue are \(self) : \(self.rawValue)"
        }
    }
}
print(Rank(rawValue: 77)!) // rawValues are only available to Int enum type
var ace = Rank.ace
print(ace.simpleDescription())
let aceRawValue = ace.rawValue
print("aceRawValue : \(aceRawValue)")

ace = .king
print(ace.simpleDescription())

ace = .seven
print(ace.simpleDescription())


print("\nEnumerations/enum---------------Ends----------------\n")

/*
* Structure || struct
* creating instances is similar to the class
* same as class but carried over by copying where classes are references
*/

print("\nStructures||struct-------------------Starts-----------------\n")


struct Card {
    var rank: Rank
    var suit: Suit
    func simpleDescription() -> String {
        return "The \(rank.simpleDescription()) of \(suit.simpleDescription())"
    }
}
let threeOfSpades = Card(rank: .three, suit: .spades)
let threeOfSpadesDescription = threeOfSpades.simpleDescription()
print("threeOfSpadesDescription : \(threeOfSpadesDescription)")


print("\nStructure||struct----------------------Ends----------------\n")

/*
* Structure vs Class
* Structures (also Enumerations) are value type. reference of reference are completely different
* Classes are reference type, references of a reference are both same
*/

print("\nStructure-Vs-Class-Enum----------------------Starts----------------\n")

struct TestStruct {
    var a : Int
    var b : Int

    init (_ v1: Int, _ v2: Int) {
        a = v1
        b = v2
    }
}
let testStruct1 = TestStruct(1, 2)
print("testStruct1.a : \(testStruct1.a) and testStruct1.b : \(testStruct1.b)")

// value type, 2 copies are different
var testStruct2 = testStruct1
testStruct2.a = 11
testStruct2.b = 22
print("testStruct2.a : \(testStruct2.a) and testStruct2.b : \(testStruct2.b)")
print("testStruct1.a : \(testStruct1.a) and testStruct1.b : \(testStruct1.b)")


class TestClass {
    var x : Int
    var y : Int

    init (_ v1: Int, _ v2: Int) {
        x = v1
        y = v2
    }
}

let testClass1 = TestClass(3, 4)
print("testClass1.a : \(testClass1.x) and testClass1.b : \(testClass1.y)")

// reference type, 2 copies are same
var testClass2 = testClass1
testClass2.x = 33
testClass2.y = 44
print("testClass2.x : \(testClass2.x) and testClass2.y : \(testClass2.y)")
print("testClass1.x : \(testClass1.x) and testClass1.y : \(testClass1.y)")

print("\nStructure-Vs-Class-Enum----------------------Ends----------------\n")

/*
* Protocols and Extensions
* Interface in other programming languages
* cannot instantiate a protocol by itself
*/
print("\nProtocol/Interface----------------------Starts----------------\n")

    protocol ExampleProtocol {
        var simpleDescription: String { get }
        mutating func adjust()
    }

    class SimpleClass: ExampleProtocol {
        var simpleDescription: String = "A very simple class."
        var anotherProperty: Int = 69105
        func adjust() {
            simpleDescription += "  Now 100% adjusted."
        }
    }
    var a = SimpleClass()
    a.adjust()
    let aDescription = a.simpleDescription

    struct SimpleStructure: ExampleProtocol {
        var simpleDescription: String = "A simple structure"
        mutating func adjust() {
            simpleDescription += " (adjusted)"
        }
    }
    var b = SimpleStructure()
    b.adjust()
    let bDescription = b.simpleDescription


print("\nProtocol/Interface----------------------Ends----------------\n")