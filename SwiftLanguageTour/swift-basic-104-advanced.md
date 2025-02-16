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