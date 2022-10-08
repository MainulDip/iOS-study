class NamedShape {
    var numberOfSides: Int = 0
    var name: String

    init(name: String) {
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

/*
* Inheritance / Sub Class / Super Class
* Implement Super Classes' Initializer with "super.init()"
*/
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

/*
* Getters & Setters
* 
*/
class TwelveOrLess {
    private var number = 0
    var filteredNumber: Int {
        get { return number }
        set { number = min(newValue, 12) }
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
