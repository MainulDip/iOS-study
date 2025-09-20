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
    } (12, 12) // lazy always requires invoked/called closure
    
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
// print("\(insS.closureWithParam2(3,4))") // closureWithParam2 is not a function type, as it's been invoked already, its only an Int
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
    required init(numberOfWheels: Int) {
        self.brand = "Generic Brand"
        super.init(numberOfWheels: numberOfWheels)
        print("carWithRequiredInit Single required init")
    }
}

class CarWithRequiredInit2: VehicleWithRequiredInit {
    var brand: String
    required init(numberOfWheels: Int) {
        self.brand = "Generic2 Brand"
        super.init(numberOfWheels: numberOfWheels)
        print("carWithRequiredInit2")
    }

    // we can have multiple required init, but should have the super class's init's param, `numberOfWheels` in this case
    required init(brand: String, numberOfWheels: Int) {
        self.brand = brand
        super.init(numberOfWheels: numberOfWheels)
        print("CarWithRequiredInit - Brand: \(brand)")
    }
}

// Single required init
let carWithRequiredInit = CarWithRequiredInit(numberOfWheels: 6)

// Multiple required init, calling any one will work
let carWithRequiredInit2a = CarWithRequiredInit2(brand: "Toyota", numberOfWheels: 4)
let carWithRequiredInit2b = CarWithRequiredInit2(numberOfWheels: 12)

// subclass gets the numberOfWheels properties from its super class 
print("carWithRequiredInit.numberOfWheels = \(carWithRequiredInit.numberOfWheels)") // 6

print(type(of: carWithRequiredInit2a)) // CarWithRequiredInit2
print(type(of: carWithRequiredInit2b)) // CarWithRequiredInit2
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
A switch case can name the value or values it matches to temporary constants or variables, for use in the body of the case. This behavior is known as `value binding`, because the values are bound to temporary constants or variables within the case’s body.

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

- Constraint for an associatedtype is written like `associatedtype T: Anothertype`. `where` clause can also be use to define further requirements on the type parameter. 

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

### Contextual where clause (with Protocol):
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

### static func vs class func:
`static` and `class` both associate a method with a class, rather than an instance of a class. The difference is that subclasses can override class methods, but they cannot override `static` methods.

```swift
class AClass {
    class func classFunction(){
        print("It's a static/type function and can be overridden")
    }
    static func staticFunction(){
        print("It's a static/type function but cannot be overridden")
    }
}
```

### Protocol in depth:

- initializer requirements | enforce `required init` when adopting 

- protocol's failable (`init?`) initializer requirements

- protocol conditional conformation | `where` clause

- protocol as Types & collection of protocols type

- protocol inheritance | protocol inheriting another protocol

- class-only protocol | `AnyObject` protocol

- protocol composition | multiple protocol 

- `is` and `as` for checking protocol conformance

- protocol extension and constraints

- protocol optional requirement (aka, optional protocol requirement).......


### Higher Order Function `reduce`:
Reduce usually return a single result (based on reduce's first `initialResult` parameter type), the second parameter is a closure, containing the `initial result` and `elements` in its param.

`reduce(into:)` a mutable variance of reduce, where the initial result is mutable and can be modified to create the final equation (`inout Result`). the closure in the `reduce(into:)` variant doesn't return.

```swift
func reducing() {
    let arr = [1, 2, 3, 4]
    let reduced = arr.reduce(0) { result, element in
        return result + element
    }
    
    let arrTuple = [(1, 10), (2, 20), (3, 30)]
    let reducedTuple = arrTuple.reduce((leftP: 0, rightP: 0)) { tup, arr in
        let left = tup.leftP + arr.0
        let right = tup.rightP + arr.1
        return (left, right)
    }
    
    let reducedTupleNoParamName = arrTuple.reduce((0, 0)) { tup, arr in
        let left = tup.0 + arr.0
        let right = tup.1 + arr.1
        return (left,right)
    }
    
    let reducedUsingIntoParameter = arrTuple.reduce(into: (0, 0)) { result, element in
        let left = result.0 + element.0
        let right = result.1 + element.1
        result = (left, right)
    }
    
    
    let _ = arr.reduce(0, +) // return 10 // using shorthand syntax
    // here the `+` is an function and it matches perfectly with the `updateAccumulatingResult` param's function signature
    
    print(reduced)
    print(reducedTuple)
    print(reducedTupleNoParamName)
    print("reducedUsingIntoParameter: \(reducedUsingIntoParameter)")
    /*
     10
     (leftP: 6, rightP: 60)
     (6, 60)
     reducedUsingIntoParameter: (6, 60)
     */
}
```

### Swift Statements All:

Loop Statements: `for-in`, `while`, `repeat-while`

Branch Statements: `if`, `guard`, `switch`
    - guard supports multiple binding `guard let a = "", b = a else { fatalError() }
    - switch has `case <match> where <condition> :`, `case let (x,y) where x == y:`
    - for `nonfrozen` enum, switch's last default case can be `@unknown default :`

Labeled Statement: 
    - label: loop `<label>: while <condition> { break/continue <label> }`
    - label: if
    - label: switch
    - label: do

Control Transfer Statement:
    - break, continue, fallthrough, return, throw

Defer Statement: defer block will run last, local defer will run before it's upper scope defer. (defer = make late)
    - defer { <code>}

```swift
func f(x: Int) {
  defer { print("First defer") }


  if x < 10 {
    defer { print("Second defer") }
    defer { print("Third defer") }
    print("End of if")
  }


  print("End of function")
}
f(x: 5)
// Prints "End of if"
// Prints "Third defer" // reverse order, last executes first
// Prints "Second defer"
// Prints "End of function"
// Prints "First defer"
```

Do statement: 
    - do { try } catch { }
    - do { try } catch <pattern 1>, <pattern 2> where <condition> {}
    - do throw(<type>) {} catch <pattern> {} catch {}


Compiler Control Statement: allows the program to change aspects of the compiler's behavior. 3 types
    - conditional-compilation-block `#if`, `#elseif`, `#else`, `#endif`
    - line-control-statement: `sourceLocation()` for debugging in build directory
    - diagnostic-statement: `#available()` or `#unavailable()` followed by #if/#elseif

```swift
// conditional compilation block examples
#if <#compilation condition#>
    <#statements#>
#elseif <#condition>
    <statements>
#else 
    <statement>
#endif

// Applied
#if compiler(>=5)
print("Compiled with the Swift 5 compiler or later")
#endif
#if compiler(>=5) && swift(<5)
print("Compiled with the Swift 5 compiler or later in a Swift mode earlier than 5")
#endif


// Conditions
/*
os() : macOS, iOS, watchOS, tvOS, visionOS, Linux, Windows

arch(): i386, x86_64, arm, arm64

swift(): >= or < followed by a version number

compiler(): >= or < followed by a version number

canImport(): A module name, that may not for all platform (iOS, watchOS)

targetEnvironment(): simulator, macCatalyst
*/
```

Line control statement example

```swift
#sourceLocation(file: <#file path#>, line: <#line number#>)
#sourceLocation()
// line-number → A decimal integer greater than zero
// file-path → static-string-literal
```

Availability Condition Example

```swift
if #available(<#platform name#> <#version#>, <#...#>, *) {
    <#statements to execute if the APIs are available#>
} else {
    <#fallback statements to execute if the APIs are unavailable#>
}

// And

if #unavailable(<#platform name#> <#version#>, <#...#>) {
    <#fallback statements to execute if the APIs are unavailable#>
} else {
    <#statements to execute if the APIs are available#>
}
```

Compile-Time Diagnostic Statement:
To emit diagnostic during compilation use `#warning(_:)` and `#error(_:)` macros

### Macros:
Macros are used minimize repetitive code by wrapping them (in source code) to be reused on several places and unwrapping/revealing (in build code) during compilation. 

* Macros add new code, but they never delete or modify existing code (non related)

2 kinds: they are called differently (`#` vs `@`)
 - `Freestanding` macros appear on their own, without being attached to a declaration. Starts with `#` like `#function` or `#warning("")`, signature `#macro(:)`
 - `Attached` macros modify the declaration that they’re attached to. Starts with `@` like `@Observable, @OptionSet<Int>` (signature `@macro<?>(??)`).......

```swift
// Freestanding Macro
func myFunction() {
    print("Currently running \(#function)") // #function returns currently running function's name
    #warning("Something's wrong") // gives a compile-time warning
}
```

```swift
// Attached Macro and Expansion
// Without using macro
struct SundaeToppings: OptionSet {
    let rawValue: Int
    static let nuts = SundaeToppings(rawValue: 1 << 0)
    static let cherry = SundaeToppings(rawValue: 1 << 1)
    static let fudge = SundaeToppings(rawValue: 1 << 2)
}

// Using Macro to minimize repetitive code
@OptionSet<Int>
struct SundaeToppings {
    private enum Options: Int {
        case nuts
        case cherry
        case fudge
    }
}

// Expanded code of the @OptionSet<Int> macro
struct SundaeToppings {
    private enum Options: Int {
        case nuts
        case cherry
        case fudge
    }


    typealias RawValue = Int
    var rawValue: RawValue
    init() { self.rawValue = 0 }
    init(rawValue: RawValue) { self.rawValue = rawValue }
    static let nuts: Self = Self(rawValue: 1 << Options.nuts.rawValue)
    static let cherry: Self = Self(rawValue: 1 << Options.cherry.rawValue)
    static let fudge: Self = Self(rawValue: 1 << Options.fudge.rawValue)
}
extension SundaeToppings: OptionSet { }
```


Docs : https://docs.swift.org/swift-book/documentation/the-swift-programming-language/macros/

### Macro vs Property wrapper:
Macros expands in compile time and Property wrapper are on run-time
Macros can be used on properties, functions, structs, classes and more, but property wrappers are only for single class/struct property.


### init override:
If a class has same init signature as super/base class, it's required to specify override.

If the superclass has initializer with argument, the base class is required to call the initializer with argument supplied `super.init(_:)` form inside child class's init, unless override


```swift
class A {
    var aDictionary: [String: String]
    
    // designated initializer 1
    init() {
        print("hi from super A")
        self.aDictionary = [:]
    }
    
    // designated initializer 2
    init(a: String){
        self.aDictionary = [:]
        print("from super: a is \(a)")
    }
}


class B: A {
    // if child class specify same init signature as super, it needs to override
    override init() {
        super.init()
    }
}

class C: A {
    // if child class different (designated) init signature, no override is required
    // here argument label `x` makes the difference
    init(x: String) {
        super.init(a: "Bismillah")
    }
    
    func sayHii() {
        print("hi from child C")
    }
}
```


Docs : https://docs.swift.org/swift-book/documentation/the-swift-programming-language/initialization#Automatic-Initializer-Inheritance


### Property wrapper's ProjectedValue:
A property wrapper can have a `ProjectedValue` along with its wrappedValue. A property annotated with a property wrapper can access to its projectedValue using the `$` prefix (if that wrapper supports it). This is the mechanism of SwiftUI Binding under the hood.

```swift
import Foundation

@propertyWrapper
struct Email {
  var wrappedValue: String
  var projectedValue: Bool {
    get {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailPred = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailPred.evaluate(with: wrappedValue)
     }
    set {
        print("Setting something")
    }
  }
}

struct Person {
    let name: String
    @Email var email: String
}


var p = Person(name: "ProjectedValue1", email: "gmail.com")
print(p.name)
print(p.email)
print(p.$email) // false, as gmail.com is not a valid email address
p.$email = true // as the projectedValue supplies a set along with get
// but it will not change the output as the setter is only printing in the console
p.email = "g@gmail.com"
print(p.$email) // true, changed g@gmail.com is a valid email address
```

### Dynamic Member Lookup `@dynamicMemberLookup`:
Its a way to access a class's/struct's member dynamically. Making the swift type system a little flexible. 

These are implemented by annotating a class/struct with the `dynamicMemberLookup` attribute and specifying one or multiple `subscript(dynamicMember member: T) -> T {}` entry.

```swift
import Foundation

@dynamicMemberLookup
struct Person {
    subscript(dynamicMember member: String) -> String {
        let properties = ["name": "Hello", "city": "World"]
        return properties[member, default: ""]
    }
}

let p1 = Person()
// even though, `name`, `city` doesn't exists as Person's member property
// this can be accessed 
print(p1.name) // Hello
print(p1.city) // World
print(p1.favoriteIceCream) // returns empty string


@dynamicMemberLookup
struct Person2 {
    subscript(dynamicMember member: String) -> String {
        let properties = ["name": "Hello", "city": "World"]
        return properties[member, default: ""]
    }

    subscript(dynamicMember member: String) -> Int {
        let properties = ["age": 26, "height": 178]
        return properties[member, default: 0]
    }
}

let p2 = Person2()
let name: String = p2.name
let age: Int = p2.age
print("name = \(name) age = \(age)") // name = Hello age = 26
print("Casting name: \(p2.name as String) and age: \(p2.age as Int)") // Casting name: Hello and age: 26
```

### Void `()` vs Never:
When a function returns `Void`, it's actual return is an empty tuple `()`. But a function returning a Never, return nothing. Never is used to crash the app.

When there is a combine operator's error type (second Generics Parameter) is Never. It means, we don't need to handle the error anymore, only the output is needs to be handled. Usually the error is handled before this steep in the pipeline. 