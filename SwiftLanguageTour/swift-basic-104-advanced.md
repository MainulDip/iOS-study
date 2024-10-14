## Overview:
Deeper dive into swift in some advanced topic. All are from https://docs.swift.org/swift-book/

### ARC (Automatic Referencee Counting) | strong/week/unowned References
To make sure that instances don’t disappear while they’re still needed, ARC tracks how many properties, constants, and variables are currently referring to each class instance. ARC will not de-allocate an instance as long as at least one active reference to that instance still exists.

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
In Depth: https://docs.swift.org/swift-book/LanguageGuide/AutomaticReferenceCounting.html ..................