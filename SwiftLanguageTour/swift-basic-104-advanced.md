### Functional Parameter | + with `lazy` | Closure Property | `let p = {}()`:
```swift
class X {
    var number = 123
    var someFnParam = { (a: Int) -> Int in
        return 12
    }
    
    let closureWithParam: (Int, Int) -> Int = { (a: Int, b: Int) -> Int in
            return a * b
    } // unless called with `()` the type will be functional signature
    
    let closureWithParam2: Int = { (a: Int, b: Int) -> Int in
            return a * b
    } (7,7) // unless called with `()` the type will be functional signature
    
    lazy var lazyClosureWithParam: Int = { (a: Int, b: Int) -> Int in
        return a * b
    } (12, 12) // lazy always requires envoked/called closure
    
    lazy var lazyFn: () -> Int = {
        return 12
    }
    
    // (a: Int) -> Int in ... type can also be inferred when specified before
    lazy var lazyFnWithParam: (Int) -> Int = { (a) -> Int in
        let calculate = self.number + a // closure doesn't carry self
        return calculate
    }
    
    // binding self inside closure (but there might be some memory leak)
    // see https://stackoverflow.com/questions/31798655/lazy-initialized-variable-holding-a-function-swift
    lazy var lazyFnWithParam2: (Int) -> Int = { [self] (a) -> Int in
        let calculate = number + a
        return calculate
    }
    
    // binding [weak self] will make the self optional, so unwrapping is necessary `self!.prop`
    lazy var lazyFnWithParam3: (Int) -> Int = { [weak self] (a) -> Int in
        let calculate = self!.number + a
        return calculate
    }

    // also possible somehow, good type inferences, NB: [weak self] is capture list
    lazy var lazyFnWithParam4 = { [weak self] (a) -> Int in
        let calculate = self!.number + a
        return calculate
    }
}

let i = X()
print("\(i.number)")
print("\(i.closureWithParam(1,2))") // 2
print("\(i.closureWithParam(3,4))") // 12
print("\(i.closureWithParam2)") // 49
// print("\(insS.closureWithParam2(3,4))") // closureWithParam2 is not a function type, as it's been envoked already, its only an Int
print("\(i.lazyClosureWithParam)") // 144
print("\(i.lazyFn())") // 12
print("\(i.lazyFnWithParam(21))") // 144
print("\(i.lazyFnWithParam4(4))") // 127
```

### initializer default value:
```swift
class X {
    var abc: String
    
    init(pabc: String = ""){
        abc = pabc
    }
}
```

### `init` in depth:

- `Default` or `Auto` initializer:
- `Primary` or `Designated` initializer:
- `Secondary` or `Convenience` ( also initializer `Delegation` ):
Secondary initializer is implemented using `convenience init` also should call the primary init. This can also be use to provide default value for primary initializer
```swift
class PersonWithConvenienceInit {
    var name: String
    var age: Int
    
    init(name: String, age: Int) {
        self.name = name
        self.age = age
    }
    
    convenience init() {
        self.init(name: "Unknown", age: 0)
    }
}

let personWithConvenienceInit = PersonWithConvenienceInit()
print("Convenience Initializer - Name: \(personWithConvenienceInit.name), Age: \(personWithConvenienceInit.age)")
```

- `Required` initializer:
this is for requiring a subclass to implement a specific initializer.
```swift
class VehicleWithRequiredInit {
    var numberOfWheels: Int
    
    required init(numberOfWheels: Int) {
        self.numberOfWheels = numberOfWheels
        print("VehicleWithRequiredInit - Number of Wheels: \(numberOfWheels)")
    }
}

class CarWithRequiredInit: VehicleWithRequiredInit {
    var brand: String
    
    required init(brand: String, numberOfWheels: Int) {
        self.brand = brand
        super.init(numberOfWheels: numberOfWheels)
        print("CarWithRequiredInit - Brand: \(brand)")
    }

    required init(numberOfWheels: Int) {
        fatalError("init(numberOfWheels:) has not been implemented")
    }
}

// Create an instance of CarWithRequiredInit
let carWithRequiredInit = CarWithRequiredInit(brand: "Toyota", numberOfWheels: 4)
print(carWithRequiredInit)
```

In this example, both Vehicle and Car classes have a required initializer that must be implemented by any subclass.

- `Failable` initializer:
Failable initializers are initializers that may fail to initialize an object. They return an optional instance, allowing you to handle initialization failure gracefully

```swift
struct Temperature {
    var celsius: Double
    
    init?(celsius: Double) {
        if celsius < -273.15 {
            return nil
        }
        self.celsius = celsius
    }
}

if let temperature = Temperature(celsius: 25) {
    print("Failable Initializer - Temperature in Celsius: \(temperature.celsius)")
} else {
    print("Failable Initializer - Invalid temperature value")
}
```

Blog Post => https://medium.com/@shahriarhossain_dev/understanding-swifts-init-methods-from-basics-to-advanced-ef094a495e04

### Failable Initializers:
https://developer.apple.com/swift/blog/?id=17



### Capture Lists in Depth | `[self] | [weak self]` in closure: 
https://www.hackingwithswift.com/articles/179/capture-lists-in-swift-whats-the-difference-between-weak-strong-and-unowned-references

### ARC (Automatic Reference Counting) | `strong/week/unowned` References:
To make sure that instances don't disappear while they're still needed, ARC tracks how many properties, constants, and variables are currently referring to each class instance. ARC will not de-allocate an instance as long as at least one active reference to that instance still exists.

To make this possible, whenever you assign a class instance to a property, constant, or variable, that property, constant, or variable makes a strong reference to the instance. The reference is called a “strong” reference because it keeps a firm hold on that instance, and doesn’t allow it to be de-allocated for as long as that strong reference remains

* Strong Refs:
Strong Ref can sometimes create memory leak by not allowing ARC to de-allocate. In the example below, making the instance nil do not de-allocate the instance memory because there are still strong reference between them through tenant and apartment
```swift
class Person {
    let name: String
    init(name: String) { self.name = name }
    var apartment: Apartment?
    deinit { print("\(name) is being deinitialized") }
}

class Apartment {
    let unit: String
    init(unit: String) { self.unit = unit }
    var tenant: Person?
    deinit { print("Apartment \(unit) is being deinitialized") }
}

var john: Person?
var unit4A: Apartment?

john = Person(name: "John Appleseed")
unit4A = Apartment(unit: "4A")

john!.apartment = unit4A
unit4A!.tenant = john

// making both nil will not de-allocated the memory by ARC, because there are still strong reference between them through tenant and apartment property
john = nil
unit4A = nil
```
* strong to weak conversion:

* unowned reference:
In Depth: https://docs.swift.org/swift-book/LanguageGuide/AutomaticReferenceCounting.html .......

### Closure Invocation:
It's same as function invoker
```swift
let abc = {print("hi")}
abc() // "hi"
```

### Swift Singleton:
```swift
class Singleton3 {
    let count = 1;
    static let sharedInstance: Singleton3 = {
        let instance: Singleton3 = Singleton3();
        return instance
    }(); // needs to be invoked with `()` as property cannot be left nil
    
    init () {
        print("print first time only")
    }
}

let first = Singleton3.sharedInstance
let second = Singleton3.sharedInstance // calling again will not trigger the init block again.
```

### Strong & Weak References (Extra info):
- A `strong` reference means that an object will not be de-allocated as long as at least one strong reference to it exists.
- A `weak` reference, on the other hand, doesn’t prevent an object from being de-allocated. When an object has only weak references, it’ll be de-allocated.......

```swift
class Child {
  var name: String
  weak var parent: Parent? // weak reference
  init(name: String, parent: Parent) {
    self.name = name
    self.parent = parent
  }
  deinit {
    print("Child \(name) is being de-initialized")
  }
}

class Parent {
  var name: String
  var children: [Child] = []
  init(name: String) {
    self.name = name
  }
  func addChild(name: String) {
    let child = Child(name: name, parent: self)
    children.append(child)
  }
  deinit {
    print("Parent \(name) is being de-initialized")
  }
}

var parent: Parent? = Parent(name: "Sandy")
parent!.addChild(name: "Patrick")
parent!.addChild(name: "Emily")
parent!.addChild(name: "Joanna")
parent = nil

//         Parent Sandy is being de-initialized
//         Child Patrick is being de-initialized
//         Child Emily is being de-initialized
//         Child Joanna is being de-initialized
```

### `operator` functions:
https://blog.logrocket.com/creating-custom-operators-in-swift/

### Mutable function param with `inout` and `&param`:
`inout` are used after function's parameter (just before Type definition) to mark it as modifiable
    - without `inout` the function parameter/s are constant/non-changeable

only `variable` can be passed to the `inout` parameter with `&` prefix
    - using `let` constant reference inside of the `inout` parameter will not work

```swift
func complexCompute( a: inout Float, b: inout Float, c: Float) {
    a = a * a + c * 3.1416
    b = b * b - c * 3.1416
}

var x: Float = 12 // when inserted into as param, needs to be prefixed with `&`
var y: Float = 34
let z: Float = 23

let computeResult: Void = complexCompute(a: &x, b: &y, c: z)
print("x = \(x), y = \(y) and unchanged z = \(z)")

```


### `switch` | value binding | `where` conditions:
`break` statement is optional but can be used to match and ignore a particular case or to break out of a matched case before that case has completed its execution. 
- The body of each case must contain at least one executable statement 
- and they need to cover all possibility (exhaustive). If not enum, there must be `default` statement. 

* switch case's value binding
A switch case can name the value or values it matches to temporary constants or variables, for use in the body of the case. This behavior is known as value binding, because the values are bound to temporary constants or variables within the case’s body.

* Where
- A switch case can use a where clause to check for additional conditions.

```swift
let anotherCharacter: Character = "a"
let message = switch anotherCharacter {
case "a":
    "The first letter of the Latin alphabet" // break is optional
case "b", "c": // combined case
    "Second and Third letter"
default: // as the `anotherCharacter` is not a enum, stating `default` is required
    "Some other character"
}

print(message) // Prints "The first letter of the Latin alphabet"

// interval or `range` matching
case 1...7:
    givenNumber = "between 1 to 7"

// matching `tuple` | `_` underscore can be used to match any character
let somePoint = (1, 1)
switch somePoint {
case (0, 0):
    print("\(somePoint) is at the origin")
case (_, 0):
    print("\(somePoint) is on the x-axis")
case (0, _):
    print("\(somePoint) is on the y-axis")
case (-2...2, -2...2):
    print("\(somePoint) is inside the box")
default:
    print("\(somePoint) is outside of the box")
}
// Prints "(1, 1) is inside the box"

// value binding | temporary constant/variable of the matched value in `case`
let anotherPoint = (2, 0)
switch anotherPoint {
case (let x, 0):
    print("on the x-axis with an x value of \(x)")
case (0, let y):
    print("on the y-axis with a y value of \(y)")
case let (x, y):
    print("somewhere else at (\(x), \(y))")
}
// Prints "on the x-axis with an x value of 2"

// switch case and where conditional
let yetAnotherPoint = (1, -1)
switch yetAnotherPoint {
case let (x, y) where x == y:
    print("(\(x), \(y)) is on the line x == y")
case let (x, y) where x == -y:
    print("(\(x), \(y)) is on the line x == -y")
case let (x, y):
    print("(\(x), \(y)) is just some arbitrary point")
}
// Prints "(1, -1) is on the line x == -y"
```


### `enum` | Raw Value | Constant | CaseIterable | Associated Values:

### `enum` with `Subscripts`:
```swift
enum Planet: Int {
    case mercury = 1, venus, earth, mars, jupiter, saturn, uranus, neptune
    static subscript(n: Int) -> Planet {
        return Planet(rawValue: n)!
    }
}
let mars = Planet[4]
print(mars)
```


### Generic-`function`, Generic-`type` and Generic-Type-Parameter:
- The placeholder type/s are called generic `type-parameter`, usually are surrounded by `<` and `>`, ie, `<T>`
- Generic functions are defined using `func fName<T>()` signature. 
- Generic types (custom generic classes/structures/enumerations, ie, Array/Dictionary) are defined using `class/struct/enum<T>{}` structure. 
- To set a constraint of the `type-parameter` use `<T: SomeConstraint>` 

Naming: When its meaningful, best to give the type-parameter a name that describe relationship, ie Key and Value in Dictionary<Key, Value> and Element in Array<Element> . If not, practices are to use `T`, `U`, `V` ect letters. 

Type Constraint: Specifying a type to be protocol/class constraint.
`func someFunction<T: SomeClass, U: SomeProtocol>(someT: T, someU: U) {}`

### Generics Associated Type in Protocol:
An associated type gives a placeholder name to a type that’s used as part of the protocol. The actual type to use for that associated type isn’t specified until the protocol is adopted. Associated types are specified with the `associatedtype` keyword. Constraint/s can also be applied `associatedtype T: Constraint-Class-Or-Protocol`

```swift
protocol Container {
    associatedtype Item
    mutating func append(_ item: Item)
    var count: Int { get }
    subscript(i: Int) -> Item { get }
}

// Container protocol adaptation
struct IntStack: Container {
    // original IntStack implementation
    var items: [Int] = []
    mutating func push(_ item: Int) {
        items.append(item)
    }
    mutating func pop() -> Int {
        return items.removeLast()
    }
    // conformance to the Container protocol
    typealias Item = Int
    mutating func append(_ item: Int) {
        self.push(item)
    }
    var count: Int {
        return items.count
    }
    subscript(i: Int) -> Int {
        return items[i]
    }
}

// Container protocol adaptation using Generics Type
struct Stack<Element>: Container {
    // original Stack<Element> implementation
    var items: [Element] = []
    mutating func push(_ item: Element) {
        items.append(item)
    }
    mutating func pop() -> Element {
        return items.removeLast()
    }
    // conformance to the Container protocol
    mutating func append(_ item: Element) {
        self.push(item)
    }
    var count: Int {
        return items.count
    }
    subscript(i: Int) -> Element {
        return items[i]
    }
}
```

### Protocol's `associatedtype` with type `constraints`:
- protocol can utilize `associatedtype` to use that as placeholder generic type. An associated type gives a placeholder name to a type that’s used as part of the protocol. The actual type to use for that associated type isn’t specified until the protocol is adopted. Associated types are specified with the associatedtype keyword.

```swift
protocol Container {
    associatedtype Item
    mutating func append(_ item: Item)
    var count: Int { get }
    subscript(i: Int) -> Item { get }
}
```

- Constraint for an associatedtype is written `associatedtype T: Anothertype`. `where` clause can also be use to define further requirements on the type parameter. 

```swift
protocol Container {
    associatedtype Item: Equatable // Equatable is the type constraint
    mutating func append(_ item: Item)
    var count: Int { get }
    subscript(i: Int) -> Item { get }
}
```

### Generic Where Clause | Extensions
generic `where` clause are used to define requirements for `type-parameters` or protocol's `associatedtype`. `where` clause are written right before the opening curly brace of a type or function’s body. For protocol's `associatedtype`, where clause are written after it's constraint. For extension, where clause are written before braces/body `{}`

```swift
protocol sth {
    associatedtype Element: Hashable, Decodable where Element: Equatable, Element: Actor
    associatedtype Item: Equatable where Item == String
}
```

- generic type extension: type parameter list from the original type definition is available within the body of the extension and can be used directly.

- in case of where clause in extension, it's also written right before the braces/body

```swift
extension Stack where Element: Equatable {
    func isTop(_ item: Element) -> Bool {
        guard let topItem = items.last else {
            return false
        }
        return topItem == item
    }
}
```

### Contextual where clause:
This make defined function available when it matches where condition/s. It's a way to define `Contextual Constraint`. Without this, we may need to break the extension in multipart using top level where clause.

* utilizing contextual where clause constraints

```swift
// utilizing contextual where clause constraints
extension Container {
    func average() -> Double where Item == Int {
        var sum = 0.0
        for index in 0..<count {
            sum += Double(self[index])
        }
        return sum / Double(count)
    }
    func endsWith(_ item: Item) -> Bool where Item: Equatable {
        return count >= 1 && self[count-1] == item
    }
}

stack1.append(37)
print(stack1.average())
// Prints "22.333333333333332"
print(stack1.endsWith(37))
// Prints "true"
```

* without contextual where clause constraints

```swift
// without contextual where clause constraints
extension Container where Item == Int {
    func average() -> Double {
        var sum = 0.0
        for index in 0..<count {
            sum += Double(self[index])
        }
        return sum / Double(count)
    }
}
extension Container where Item: Equatable {
    func endsWith(_ item: Item) -> Bool {
        return count >= 1 && self[count-1] == item
    }
}
```

### Generic Subscripts:
Subscripts can be generic, and they can include generic where clauses. You write the placeholder type name inside angle brackets after subscript, and you write a generic where clause right before the opening curly brace of the subscript’s body

```swift
extension Container {
    subscript<Indices: Sequence>(indices: Indices) -> [Item]
            where Indices.Iterator.Element == Int {
        var result: [Item] = []
        for index in indices {
            result.append(self[index])
        }
        return result
    }
}
```

### Generics type's Equatable Conformation:
The Swift standard library defines a protocol called Equatable, which requires any conforming type to implement the equal to operator (==) and the not equal to operator (!=) to compare any two values of that type. All of Swift’s standard types automatically support the Equatable protocol.  

```swift
func findIndex<T: Equatable>(of valueToFind: T, in array:[T]) -> Int? {
    for (index, value) in array.enumerated() {
        if value == valueToFind {
            return index
        }
    }
    return nil
}
let doubleIndex = findIndex(of: 9.3, in: [3.14159, 0.1, 0.25])
// doubleIndex is an optional Int with no value, because 9.3 isn't in the array
let stringIndex = findIndex(of: "Andrea", in: ["Mike", "Malcolm", "Andrea"])
// stringIndex is an optional Int containing a value of 2

```