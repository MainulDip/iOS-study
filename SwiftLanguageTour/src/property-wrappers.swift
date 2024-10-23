/*
* Property Wrappers
* There are some including required maybe, run from xcode to test
*/


@propertyWrapper
struct TwelveOrLess {
    private var number = 0
    var wrappedValue: Int {
        get { return number }
        set { number = min(newValue, 12) }
    }
}

// struct SmallRectangle {
//     @TwelveOrLess var height: Int
//     @TwelveOrLess var width: Int
// }


// var rectangle = SmallRectangle()
// print(rectangle.height)
// // Prints "0"

// rectangle.height = 10
// print(rectangle.height)
// // Prints "10"

// rectangle.height = 24
// print(rectangle.height)
// // Prints "12"

// Using non-attribute style
struct SmallRectangle2 {
    private var _height = TwelveOrLess()
    private var _width = TwelveOrLess()
    var height: Int {
        get { return _height.wrappedValue }
        set { _height.wrappedValue = newValue }
    }
    var width: Int {
        get { return _width.wrappedValue }
        set { _width.wrappedValue = newValue }
    }
}


var rectangle2 = SmallRectangle2()
print(rectangle2.height)
// Prints "0"

rectangle2.height = 10
print(rectangle2.height)
// Prints "10"

rectangle2.height = 24
print(rectangle2.height)
// Prints "12"


/*
* Wrapped Properties Initial values
* Implement multiple initializers
*/
print("\nWrapped Properties Initial/Default values-----------------------------Starts---------------------------\n")
@propertyWrapper
struct SmallNumber {
    private var maximum: Int
    private var number: Int

    var wrappedValue: Int {
        get { return number }
        set { number = min(newValue, maximum) }
    }

    // just populating the initial properties
    init() {
        maximum = 12
        number = 0
    }
    
    // init(wrappedValue:) is required to deal with default properties in the applied properties
    init(wrappedValue: Int) {
        maximum = 12
        number = min(wrappedValue, maximum)
    }

    // the 2nd param can be used to modify logic through @wrapper(T,T) contractor
    init(wrappedValue: Int, maximum: Int) {
        self.maximum = maximum
        number = min(wrappedValue, maximum)
    }
}

struct ZeroRectangle {
    @SmallNumber var height: Int
    @SmallNumber var width: Int
}

var zeroRectangle = ZeroRectangle()
print(zeroRectangle.height, zeroRectangle.width)
// Prints "0 0"


struct UnitRectangle {
    @SmallNumber var height: Int = 1
    @SmallNumber var width: Int = 1
}

var unitRectangle = UnitRectangle()
print(unitRectangle.height, unitRectangle.width)
// Prints "1 1"


struct NarrowRectangle {
    @SmallNumber(wrappedValue: 2, maximum: 5) var height: Int
    @SmallNumber(wrappedValue: 3, maximum: 4) var width: Int
}

var narrowRectangle = NarrowRectangle()
print(narrowRectangle.height, narrowRectangle.width)
// Prints "2 3"

narrowRectangle.height = 100
narrowRectangle.width = 100
print(narrowRectangle.height, narrowRectangle.width)
// Prints "5 4"


print("\nWrapped Properties Initial values-----------------------------Ends---------------------------\n")


/*
* Static / Type Properties : properties that belong to the type itself, not to any one instance of that type
* There will only ever be one copy of these properties, no matter how many instances of that type you create. These kinds of properties are called type properties. 
* The example below shows the syntax for stored and computed type properties and how to call them
* Type properties are queried and set on the type, not on an instance of that type
*/
print("\nStatic/Type-Properties-----------------------------Ends---------------------------\n")
    
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



print("\nStatic/Type-Properties-----------------------------Ends---------------------------\n")