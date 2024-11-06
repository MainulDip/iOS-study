## Swift Object Oriented Programmings:
Topics covered includes following ->

### Struct vs Class | Value vs Reference:
structs/structures are to represent common kinds of data. Structs are `value based`, not reference based like classes. local changes to a structure aren’t visible to the rest of your app unless you intentionally communicate those changes as part of the flow of your app. The Swift standard library and Foundation use structures for types you use frequently, such as numbers, strings, arrays, and dictionaries

if 2 or more variable is referencing to a same instance of a struct. Each of them can have a separate copy of that struct (hence value based). The values/states of each referenced instance can be different. None of them are aware if one instance has changed one of it's property's value. But classes (being referenced based) multiple variable referencing to that same class instance point to the class instance itself. Updating anything in one instance updates all other references.  

But when two different class instances have the same value for each of their stored properties, they’re still considered to be different by the identity operator (===). It also means that when you share a class instance across your app, changes you make to that instance are visible to every part of your code that holds a reference to that instance.

### Class vs Structure Example :
```swift
class StudentClass {
   var name: String
   var grade: Int
   init(name: String, grade: Int) {
      self.name = name
      self.grade = grade
   }
}
let student1 = StudentClass(name: "Ramesh Chandra", grade: 9)

let student2 = student1
student2.name = "Ramesh Kant" // this will also make the student1 name "Ramesh Kant", as classes are references based
print("student1 name: \(student1.name)") // student1 name: Ramesh Kant
print("student2 name: \(student2.name)") // student1 name: Ramesh Kant

struct StudentStruct {
   var name: String
   var grade: Int
}
let student3 = StudentStruct(name: "Anish Sharma", grade: 8)
var student4 = student3
student4.name = "Anish Gupta" // this will not change the student3 name, as Structures are value based
print("student3 name: \(student3.name)") // student3 name: Anish Sharma
print("student4 name: \(student4.name)") // student4 name: Anish Gupta
```
Output:
student1 name: Ramesh Kant
student2 name: Ramesh Kant
student3 name: Anish Sharma
student4 name: Anish Gupta


Note: changing value of a classes form a referenced class will also change the referenced class's value. Structure will keep the value separate from referenced structures.

### When to use Struct and when Class:

* Use structures by default.

* Use classes when you need Objective-C interoperability, and shared data in SwiftUI

* Use classes when you need to control the identity of the data you’re modeling.

* Use structures along with protocols to adopt behavior by sharing implementations.

### Using Struct as Data Class (like data class in kotlin):

```swift
struct PeyPalRecord {
    let myID: Int
    var myNickname: String
    var recommendedPenPalID: Int
}

var myRecord = try JSONDecoder().decode(PeyPalRecord.self, from: jsonResponse)
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

- first class citizen and adopts many traditional class features
- supports computedProperties, instance methods, init, supports inheritance and protocol conformation 
- values defined in enum's are called its `enumeration case` (defined by case keyword)
- enumeration case can have it's own constructor
- if type is already known (variable initialization), type can be dropped in the subsequent use.
- like `.result` and `.failure` are dropping `ServerResponse` type 
```swift
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
```


### Structure/Enumeration vs Class (value type vs reference type):
* value type `struct` vs reference type `class`

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
### Protocol | Delegation Pattern | Event Firing:
Delegation pattern works like event firing. The heat of it lies in the class's reference type behavior. 
Delegation pattern: A class property can call the assigned object's method without knowing (being agnostic) the later implemented class before hand by the help of protocol/interface. 
In reality, the (later) class implementing the protocol/interface, assign itself to the caller class's property (delegate) on it's init block.
```swift
protocol AdvancedLifeSupport {
    func performCPR()
}

class EmergencyCallHandler {
    var delegate: AdvancedLifeSupport?

    func assessSituation() {
        print("Can you tell me what happened?")
    }

    func medicalEmergency() {
        delegate?.performCPR() ?? print("No Delegation Found Yet")
        
    }
}

// class will also work
struct Paramedic: AdvancedLifeSupport {

    let id: String = "1234" // just for comparing object

    // init binds the EmergencyCallHandler
    init(_ handler: EmergencyCallHandler) {
        handler.delegate = self // assigning self to the optional `delegate` property of passed instance of the EmergencyCallHandler.
    }

    // performCPR method is required by AdvancedLifeSupport protocol
    func performCPR() {
        print("The paramedic does chest compression, 30 per second")
        
    } 
}

var ECH = EmergencyCallHandler()
ECH.medicalEmergency() // will print: No Delegation Found Yet
var someParamedic = Paramedic(ECH)
ECH.medicalEmergency() // will print: The paramedic does chest compression, 30 per second

/**
* As class works by reference (on same instance), when the handler.delegate = self is called through Paramedic(ECH) Instantiation, 
* then "delegated: AdvancedLifeSupport?" optional property of the
* EmergencyCallHandler is actually updated/assigned with the someParamedic object. 
* So the ECH.medicalEmergency() will call the same someParamedic.performCPR() method.
*/

// Checking if both are same object
if ((ECH.delegate! as! Paramedic).id == someParamedic.id) {
    print("Both are same object")
} else {
    print("Not Same")
}

// print((ECH.delegate! as! Paramedic).id)
// print(someParamedic.id)
```

### Protocol and mutation:
To change self property, protocol should specify `mutating`. Class doesn't need that, but struct is required. 

```swift
import Foundation // to use pow(), we need Foundation

protocol Ex {
    var a: Double {get};
    var b: Double {get set};
    mutating func res() -> Double;
}

struct S1: Ex {
    var a = 7.0;
    var b = 7.0;
    mutating func res() -> Double {
        // pow accepts only decimal, hence double
        a = pow(a, 2); // or a = a * a;
        b = pow(b, 2); // or b = b * b;
        return a + b;
    }
}

class C1: Ex {
    var a = 7.0;
    var b = 7.0;
    func res() -> Double {
        a = pow(a, 2); // or a = a * a;
        b = pow(b, 2); // or b = b * b;
        return a + b;
    }
}
```

### Extensions:
Extensions add new functionalities to an existing class, structure, enumeration, or protocol type. This includes the ability to extend types for which you don’t have access to the original source code (known as retroactive modeling). Extensions are similar to categories in Objective-C. (Unlike Objective-C categories, Swift extensions don’t have names.)

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

### Access Modifiers `open | public | internal | fileprivate | private`:
All entries have `internal` access level by default. 
Note, swift doesn't have `protected` modifiers....
docs: https://docs.swift.org/swift-book/documentation/the-swift-programming-language/accesscontrol/....
```swift
open class SomeOpenClass {}
public class SomePublicClass {}
internal class SomeInternalClass {}
fileprivate class SomeFilePrivateClass {}
private class SomePrivateClass {}


open var someOpenVariable = 0
public var somePublicVariable = 0
internal let someInternalConstant = 0
fileprivate func someFilePrivateFunction() {}
private func somePrivateFunction() {}
```

### Properties in depth:
See ./src/properties.swift

#### Stored Properties (regular properties):
stored property is a constant or variable that’s stored as part of an instance of a particular class or structure. Every stored property should have value when initialized or optional.
```swift
struct FixedLengthRange {
    var firstValue: Int
    let length: Int
}
var rangeOfThreeItems = FixedLengthRange(firstValue: 0, length: 3)
// the range represents integer values 0, 1, and 2
rangeOfThreeItems.firstValue = 6
// the range now represents integer values 6, 7, and 8
```
Second Example
```swift
struct StoredPropEx {
  private var sth: Int;
  var sthGet: Int {
    sth;
  }
  // init block is required to map contstructor property to a private/protected property. 
  init(_ a: Int){
    sth = a;
  }
}

// var storedPropEx = StoredPropEx(sth: 7); // if all are internal default and init block is not specified
var storedPropEx = StoredPropEx(7);
// print("\(storedPropEx.sth)") // sth is inaccessible as it is private
print("\(storedPropEx.sthGet)") // prints 7
```

#### computed property:
When a property is computed using other stored properties. Use signature like `var computedProp: T { get{return:} set{} }`.

* Note: computed property must have an explicit type

```swift
struct S {
  var prop1: Int = 1
  var prop2: Int = 2
  var comp: Int { prop1 + prop2 }
  var comp2: Int {
    get {
      return prop1 + prop2 * 2
    }
    set {
      print("newValue: \(newValue) is available here")

      prop1 = prop1 * newValue
      self.prop2 = prop2 * newValue // defining self is optional or `weak self` is allowed. explicit self is required inside lazy variables

      // Note: `oldValue` is only available in `didSet` property observer.
    }
  }
}

var s = S()
print("\(s.comp)") // 3
s.comp2 = 2 // newValue: 2 is available here
print("\(s.comp)") // 6
```

#### property observers | `willSet` & `didSet`:
observers `willSet/didSet` can be applied to the stored properties (not in computed properties) as side effect triggers. `newValue` is available in `willSet` and `oldValue` is available in `didSet`.

```swift
struct Person {
    var clothes: String {
        willSet {
            updateUI(msg: "I'm changing from \(clothes) to \(newValue)")
        }


        didSet {
            updateUI(msg: "I just changed from \(oldValue) to \(clothes)")
        }
    }
}

func updateUI(msg: String) {
    print(msg)
}

var taylor = Person(clothes: "T-shirts")
taylor.clothes = "short skirts"

// I'm changing from T-shirts to short skirts
// I just changed from T-shirts to short skirts
```

#### Read-Only Computed Properties:
Those computed properties with only `get` specified. Or just a return inside of `{}` curly braces (default getter). 

#### lazy properties | `lazy var`:
Lazy properties are only initialize/evaluated/calculated when accessed for the first time (to avoid unnecessary computation or nil pointer exception). Strong self is required to point properties.

- signature `lazy var` (not `let`)
- type should be explicit
- define using `{}` lambda block and end with invoke sign `()`
- Strong self is required to point properties.

```swift
struct Person {
    var age = 16

    lazy var fibonacciOfAge: Int = {
        fibonacci(of: self.age)
    }()

    func fibonacci(of num: Int) -> Int {
        if num < 2 {
            return num
        } else {
            return fibonacci(of: num - 1) + fibonacci(of: num - 2)
        }
    }
}

var singer = Person()
print(singer.fibonacciOfAge)
```

### Property Wrappers (@propertyWrapper) | requires `wrappedValue` computed properties:
A property wrapper adds a layer of separation between code that manages how a property is stored and the code that defines a property. It helps to write the management code once (when defining the wrapper), and then reuse that management code by applying it to multiple properties. Supports both struct and class.

* Requirements
- @propertyWrapper annotation
- `wrappedValue` stored property, each property wrapper type should contain this stored property, which tells Swift which underlying value that’s being wrapped

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

### Property Wrapper Example 2:
To set default values in the wrapped property (on the applied props), init(wrappedValue:) is required

```swift
import Foundation // to use capitalized method

@propertyWrapper 
struct Capitalized {
    var wrappedValue: String {
        didSet { wrappedValue = wrappedValue.capitalized }
    }

    // init(wrappedValue:) is required to deal with default properties in the applied properties
    init(wrappedValue: String) {
        self.wrappedValue = wrappedValue.capitalized
    }
}

struct User {
    @Capitalized var firstName: String
    @Capitalized var lastName: String = "abc" // this requires an init(wrappedValue:) block
}

// John Appleseed
var user = User(firstName: "john")

print("UserName = \(user.firstName) \(user.lastName)") // John Abc

user.lastName = "yoo"
print("UserName = \(user.firstName) \(user.lastName)") // John Yoo
```


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

### Subscripts
Classes, structures, and enumerations can define subscripts, which are shortcuts for accessing the member elements of a collection, list, or sequence. 

```swift
/*
* Basic Subscripts
* define in class/struct using "subscript (param: type) -> return-type { body }"
* call on newInstance[value]
*/

struct TimesTable {
    let multiplier: Int
    subscript(index: Int) -> Int {
        return multiplier * index
    }
}
let threeTimesTable = TimesTable(multiplier: 3)
print("seven times three is \(threeTimesTable[7])") // prints "seven times three is 21"
```

### Generics:

### Methods