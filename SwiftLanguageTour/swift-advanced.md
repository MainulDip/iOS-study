## Overview:
Deeper dive into swift in some advanced topic. All are from https://docs.swift.org/swift-book/

### ARC (Automatic Referencee Counting) | stront/week/unowned References:
To make sure that instances don’t disappear while they’re still needed, ARC tracks how many properties, constants, and variables are currently referring to each class instance. ARC will not deallocate an instance as long as at least one active reference to that instance still exists.

To make this possible, whenever you assign a class instance to a property, constant, or variable, that property, constant, or variable makes a strong reference to the instance. The reference is called a “strong” reference because it keeps a firm hold on that instance, and doesn’t allow it to be deallocated for as long as that strong reference remains

* Strong Ref To Weak Ref:
Strong Ref can sometimes create mamory leack by not allowing ARC to deallocate. In the example below, making the instance nil do not deallocate the instance mamory because there are still strong reference between them through tanant and apartment.
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

// msking both nil will not deallocated the memory by ARC, because there are still strong reference between them through tanant and apartment property
john = nil
unit4A = nil
```

In Depth: https://docs.swift.org/swift-book/LanguageGuide/AutomaticReferenceCounting.html