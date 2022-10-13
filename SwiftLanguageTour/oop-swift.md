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

### Setter, Getter, willset and didset:
* get/set (getter/setter):
* set implicit param: set { backingField = newValue} || set (value) { backingField = value }
* willset and didset methods to run before and after setting new values to class properties. These will not work togather with get/set


### Structures:

### Enumerations:
An enumeration defines a common type for a group of related values. By these enumeration cases can specify associated values of any type to be stored along with each different case value.


### Structure/Enumeration vs Class (value type vs reference type):
* value type vs reference type

* structure needs "mutating" keyword before method name to change struct's property, but methods on a class can always modify the class so no need for mutating keyword.

### Protocol (like Interface):
A protocol defines a blueprint of methods, properties, and other requirements that suit a particular task or piece of functionality. The protocol can then be adopted by a class, structure, or enumeration to provide an actual implementation of those requirements. Any type that satisfies the requirements of a protocol is said to conform to that protocol.

In addition to specifying requirements that conforming types must implement, you can extend a protocol to implement some of these requirements or to implement additional functionality that conforming types can take advantage of.

```swift
protocol FirstProtocol {
    // protocol definition goes here
}

protocol SecondProtocol {
    // protocol definition goes here
}

// Implementing protocol folows by coma after inheriting super classes (if any)

class SomeClass: SomeSuperclassIfAny, FirstProtocol, SecondProtocol {
    // class definition goes here
}
```

### Extensions:
Extensions add new functionality to an existing class, structure, enumeration, or protocol type. This includes the ability to extend types for which you don’t have access to the original source code (known as retroactive modeling). Extensions are similar to categories in Objective-C. (Unlike Objective-C categories, Swift extensions don’t have names.)

Extensions in Swift can:

* Add computed instance properties and computed type properties

*  Define instance methods and type methods

* Provide new initializers

*  Define subscripts

* Define and use new nested types

*  Make an existing type conform to a protocol

In Swift, you can even extend a protocol to provide implementations of its requirements or add additional functionality that conforming types can take advantage of.
```swift
extension Double {
        var km: Double { return self * 1_000.0 }
        var m: Double { return self }
        var cm: Double { return self / 100.0 }
        var mm: Double { return self / 1_000.0 }
        var ft: Double { return self / 3.28084 }
    }
    let oneInch = 25.4.mm
    print("One inch is \(oneInch) meters")
    // Prints "One inch is 0.0254 meters"
    let threeFeet = 3.ft
    print("Three feet is \(threeFeet) meters")
    // Prints "Three feet is 0.914399970739201 meters"
```

### Properties In Depth:


### Property Wrappers (@propertyWrapper):
A property wrapper adds a layer of separation between code that manages how a property is stored and the code that defines a property. It helps to write the management code once (when defining the wrapper), and then reuse that management code by applying it to multiple properties. It's somewhat like delegated properties in kotlin.
```swift
@propertyWrapper
struct TwelveOrLess {
    private var number = 0
    var wrappedValue: Int {
        get { return number }
        set { number = min(newValue, 12) }
    }
}

struct SmallRectangle {
    @TwelveOrLess var height: Int
    @TwelveOrLess var width: Int
}


var rectangle = SmallRectangle()
print(rectangle.height)
// Prints "0"

rectangle.height = 10
print(rectangle.height)
// Prints "10"

rectangle.height = 24
print(rectangle.height)
// Prints "12"
```

Example: [property-wrappers.swift](./src/property-wrappers.swift)


### Static / Type-Properties:
Properties that belong to the type itself, not to any one instance of that type. There will only ever be one copy of these properties, no matter how many instances of that type you create. These kinds of properties are called type properties. 

* Type properties are queried and set on the type, not on an instance of that type

```swift
/* 
* The example below shows the syntax for stored and computed type properties and how to call them
*/

struct SomeStructure {
    static var storedTypeProperty = "Some value."
    static var computedTypeProperty: Int {
        return 1
    }
}
enum SomeEnumeration {
    static var storedTypeProperty = "Some value."
    static var computedTypeProperty: Int {
        return 6
    }
}
class SomeClass {
    static var storedTypeProperty = "Some value."
    static var computedTypeProperty: Int {
        return 27
    }
    class var overrideableComputedTypeProperty: Int {
        return 107
    }
}

print(SomeStructure.storedTypeProperty)
// Prints "Some value."
SomeStructure.storedTypeProperty = "Another value."
print(SomeStructure.storedTypeProperty)
// Prints "Another value."
print(SomeEnumeration.computedTypeProperty)
// Prints "6"
print(SomeClass.computedTypeProperty)
// Prints "27"
```