/**
* Strong Reference
*/
print("Example 1 (Strong Reference) ----------Starts---------")
class Ex1Person {
    let name: String
    init(name: String) {
        self.name = name
        print("\(name) is beding initialized")
    }
    deinit {
        print("\(name) is being deinitialized")
    }
}

var reference1: Ex1Person?
var reference2: Ex1Person?
var reference3: Ex1Person?
// weak var will not count as weak reference, hence, ARC will not count this as strong, and will deallocate if no strong references are available
// weak var reference3: Ex1Person?

reference1 = Ex1Person(name: "John Appleseed")
// Prints "John Appleseed is beding initialized"


reference2 = reference1
reference3 = reference2

reference1 = nil
reference2 = nil
// reference3 = nil
print(reference3!.name) // still works because of strong ref
// Prints "John Appleseed"

reference3 = nil // when this line is run, deinitializer will be called as there are no strong reference left
// Prints "John Appleseed is being deinitialized"

if let reference3 = reference3 {
    print(reference3.name)
} else {
    print("Now the object is deallocated!")
}
// Prints "Now the object is deallocated!"

print("Example 1 (Strong Reference) ----------Ends---------\n")


/**
* Strong Reference Example 2
* Problem -> after removing object references it makes the object inaccessable but internal strong references prevent objects from being deallocated
* no deallocation on inaccessable object creates memory leack 
*/
print("Example 2 (Strong Reference) ----------Starts---------")
 
class Ex2Person {
    let name: String
    init(name: String) { 
        self.name = name 
        print("Ex2Person \(name) object is initialized")
        }
    var apartment: Ex2Apartment?
    deinit { print("\(name) is being deinitialized") }
}

class Ex2Apartment {
    let unit: String
    init(unit: String) { 
        self.unit = unit 
        print("Ex2Apartment \(unit) object is initialized")
        }
    var tenant: Ex2Person?
    deinit { print("Ex2Apartment \(unit) is being deinitialized") }
}


var john: Ex2Person?
var unit4A: Ex2Apartment?


john = Ex2Person(name: "John Appleseed")
// Prints "Ex2Person John Appleseed object is initialized"
unit4A = Ex2Apartment(unit: "4A")
//Prints "Ex2Apartment 4A object is initialized"


john!.apartment = unit4A // setting Ex2Persons Apartment
unit4A!.tenant = john // setting Apartments Tenant

john = nil // will not deallocate the Ex2Person Object as there is still a strong reference set avobe by john!.apartment
unit4A = nil // same here, no deallocation because of the above unit4A!.tenant setter. Also those non deallocated objects are now inaccessable, hence creating memory leack 


print("Example 2 (Strong Reference) ----------Ends---------\n")

/**
* weak Reference
*/
print("Example 3 (weak Reference) ----------Starts---------")

    class PersonEx3 {
        let name: String
        init(name: String) { self.name = name }
        var apartment: ApartmentEx3?
        deinit { print("\(name) is being deinitialized") }
    }

    class ApartmentEx3 {
        let unit: String
        init(unit: String) { self.unit = unit }
        weak var tenant: PersonEx3?
        deinit { print("ApartmentEx3 \(unit) is being deinitialized") }
    }

    var johnEx3: PersonEx3?
    var unit4AEx3: ApartmentEx3?

    johnEx3 = PersonEx3(name: "JohnEx3 Appleseed")
    unit4AEx3 = ApartmentEx3(unit: "4A")

    johnEx3!.apartment = unit4AEx3
    unit4AEx3!.tenant = johnEx3

    johnEx3 = nil // if this line is commented, setting unit4AEx3 to nil will not call any deinit becaues johnEx3!.apartment still holding a strong reference to unit4AEx3 instance
    // setting johnEx3 = nil will call PersonEx3 's deinit, because, there is only a weak reference holding that instance inside ApartmentEx3 class
    
    print("unit4AEx3!.tenant: \(unit4AEx3!.tenant)") // Prints "unit4AEx3!.tenant: nil"
    
    unit4AEx3 = nil
    // setting unit4AEx3 = nil will call deinit of the ApartmentEx3's class as PersonEx3 is deallocated alredy, no strong reference exists

    
    // though PersonEx3's apartment is not declared "weak", if no strong reference is found for PersonEx3 object instance ARC will deallocate it, and everythig will be on default state on that class, hence appartment will be nil
    // if unit4AEx3 is set to nil only (leaving johnEx3 instance intact), no deinit will be called becaues johnEx3!.apartment still holding a strong reference to unit4AEx3 instance



print("Example 3 (weak Reference) ----------Ends---------\n")

/**
* unwoned Reference
* only when it is sure that the reference always refers to an instance that hasn’t been deallocated
* if try to access deallocated instances reference set with unowned, it will throw runtime error where "weak" will return nil
*/
print("Example 1 (unowned References) ----------Starts---------")


print("Example 1 (unowned References) ----------Ends---------\n")

/**
* optional unowned Reference
*/
print("Example 1 (optional unowned References) ----------Starts---------")

print("Example 1 (optional unowned References) ----------Ends---------\n")

/**
* Closure Strong Reference Cycles
*/
print("Example 1 (Closure Strong Reference Cycles) ----------Starts---------")

print("Example 1 (Closure Strong Reference Cycles) ----------Ends---------\n")