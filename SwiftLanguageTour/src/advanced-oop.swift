class Person {
    let name: String
    init(name: String) {
        self.name = name
        print("\(name) is beding initialized")
    }
    deinit {
        print("\(name) is being deinitialized")
    }
}

var reference1: Person?
var reference2: Person?
var reference3: Person?
// weak var will not count as weak reference, hence, ARC will not count this as strong, and will deallocate if no strong references are available
// weak var reference3: Person?

reference1 = Person(name: "John Appleseed")


reference2 = reference1
reference3 = reference2

reference1 = nil
reference2 = nil
// reference3 = nil
print(reference3!.name) // still works because of strong ref

// reference3 = nil
// print(reference3?.name) // now the deinitializer will be called (if not weak var) and the object is now deallocated