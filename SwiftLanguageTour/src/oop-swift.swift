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