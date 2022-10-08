## Swift Object Oriented Programmings:
Topics covered includes following ->

### Struct (Data) vs Class:
structs/structures are to represent common kinds of data. Structs are value based, not reference based like classes. local changes to a structure aren’t visible to the rest of your app unless you intentionally communicate those changes as part of the flow of your app. The Swift standard library and Foundation use structures for types you use frequently, such as numbers, strings, arrays, and dictionaries


when two different class instances have the same value for each of their stored properties, they’re still considered to be different by the identity operator (===). It also means that when you share a class instance across your app, changes you make to that instance are visible to every part of your code that holds a reference to that instance.

* Use structures by default.

* Use classes when you need Objective-C interoperability

* Use classes when you need to control the identity of the data you’re modeling.

* Use structures along with protocols to adopt behavior by sharing implementations.

```swift
struct PenPalRecord {
    let myID: Int
    var myNickname: String
    var recommendedPenPalID: Int
}

var myRecord = try JSONDecoder().decode(PenPalRecord.self, from: jsonResponse)
```


### Object, Classes and Inheritances :
* class / base-class : Swift classes don’t inherit from a universal base class (unlike kotlin, All classes in Kotlin have a common superclass, Any). Classes you define without specifying a superclass automatically become base classes for you to build upon on swift.

* init / constructor : init block is the class constructor
* super-class constructor parameters on sub-class : super.init() is used to map with super-class constructor.
* deinit / deallocation: deinit block (no param allowed) is used to do cleanup when the object is deallocated.
```swift
// simple swift class or Base class
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
```



### Structures:

### Enumerations: