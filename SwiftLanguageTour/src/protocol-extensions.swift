/*
* Protocols and Extensions
* Interface in other programming languages
* cannot instantiate a protocol by itself
* Extensions can add computed instance properties and computed type properties to existing types.
* extension must not contain stored properties like (var sth: String = "Stored Properties")
*/
print("\nProtocol/Interface----------------------Starts----------------\n")

    protocol ExampleProtocol {
        var simpleDescription: String { get }
        mutating func adjust()
    }

    class SimpleClass: ExampleProtocol {
        var simpleDescription: String = "A very simple class."
        var anotherProperty: Int = 69105
        func adjust() {
            simpleDescription += "  Now 100% adjusted."
        }
    }
    var a = SimpleClass()
    a.adjust()
    let aDescription = a.simpleDescription
    print(aDescription)

    struct SimpleStructure: ExampleProtocol {
        var simpleDescription: String = "A simple structure"
        mutating func adjust() {
            simpleDescription += " (adjusted)"
        }
    }
    var b = SimpleStructure()
    b.adjust()
    let bDescription = b.simpleDescription
    print(bDescription)


    print("\nUsing Protocol Name As other Named Type ---------------------\n")

    let protocolValue: ExampleProtocol = a
    // let protocolValue = a // type inferrence is also possible
    print(protocolValue.simpleDescription)
    // Prints "A very simple class.  Now 100% adjusted."
    // print(protocolValue.anotherProperty)  // Uncomment to see the error



    print("\nExtension--------------------------Example 1-------------------\n")

    
    extension Int: ExampleProtocol {
        var simpleDescription: String { // extensions can return computed instance properties, not stored
            return "Some Description For Number \(self)"
        }

        mutating func adjust() {
            self += 42
        }
    }
    var x = 7
    print(x.simpleDescription)
    x.adjust()
    print(x.simpleDescription)

    print("\nExtension ------------------- Example 2 -------------------------\n")
    
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



print("\nProtocol/Interface----------------------Ends----------------\n")