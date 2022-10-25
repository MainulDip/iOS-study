/*
* Stored Properties
* every stored property should have value when initialized, nil is also a value, as docs specify
* Classes and structures must set all of their stored properties to an appropriate initial value by the time an instance of that class or structure is created. Stored properties cannot be left in an indeterminate state.
* lazy properties must have an initializer, this will only be called when accessed only, as it could be resoruce intensive
*/

struct FixedLengthRange {
    var directAssaignment: Int = 1234 // stored property with direct assaignment with initial value
    var firstValue: Int // as it is not assigned, have to assigned value with init call
    let length: Int = 7 // though it is const, if not set/assaigned with value, can be set using init block
    var someVar: Int? // possible nil type is also a initial value
    private var sth: Int
    lazy var callMeLater: Int = Int() // lazy properties must have an initializer, this will only be called when accessed only
    init(_ a: Int){
        firstValue = a
        sth = a + length
    }
}
var rangeOfThreeItems = FixedLengthRange(7)
print("\(rangeOfThreeItems.firstValue) \(rangeOfThreeItems.length)")

print(rangeOfThreeItems.callMeLater)
rangeOfThreeItems.callMeLater = 77
print(rangeOfThreeItems.callMeLater)

print("\nStored-Lazy-Properties-----------------------------Ends-----------------------------\n")


/*
* Computed Properties
* by defining custom getter and setter
* A computed property with a getter but no setter is known as a read-only computed property.
* can simplify the declaration of a read-only computed property by removing the get keyword and its braces
*/

print("\nComputed-Properties-----------------------------Starts-----------------------------\n")

struct ValueHolder {
    var highest = 100
    var lowest = 0
    var findMiddle: Int {
        get {
            return (highest + lowest) / 2
        }

        set {
            highest = newValue / 2
            lowest = newValue / 2
        }
    }
    
    var readOnlyGet: String {
        return "Total is : \(highest + lowest)"
    }
}
var vh = ValueHolder()
print(vh.findMiddle)
vh.findMiddle = 40
print(vh.findMiddle)

print(vh.readOnlyGet)

print("\nComputed-Properties-----------------------------Starts-----------------------------\n")


/*
* Lazy Properties Test
* 
*/
print("\nLazy-Properties-Test-----------------------------Starts-----------------------------\n")

class ClsCallLater {
    init() {
        print("I'm Initialized from \(self)")
    }
}

struct StrCallLater {
    init() {
        print("I'm Initialized from \(self)")
    }
}

class LazyTesting {
    var nonLazy: ClsCallLater = ClsCallLater()
    lazy var lazyCall: StrCallLater = StrCallLater()
}

// var ccl = ClsCallLater()
// var scl = StrCallLater()

var lazyTesting = LazyTesting()
// I'm Initialized from properties.ClsCallLater // it prints automatically, because of not being lazy

// lazy will only executed when called later
var callTheLazy = lazyTesting.lazyCall
// I'm Initialized from StrCallLater() // only initialized if called/used

// Note
// Calling lazyTesting.lazyCall will not do anything as ARC will not count it as any reference, so maybe will not allocate anyting unless used/print/referenced

print("\nLazy-Properties-Test-----------------------------Starts-----------------------------\n")


/*
* Observers
* willSet and didSet
* works with difined + inherited stored and inherited computed properties
* willSet is called just before the value is stored.
* didSet is called immediately after the new value is stored.
*/

print("\nProperty-Observers-willSet-didSet----------------------Strats---------------------\n")

    class StepCounter {
        var totalSteps: Int = 0 {
            willSet(newTotalSteps) {
                print("About to set totalSteps to \(newTotalSteps)")
            }
            didSet {
                if totalSteps > oldValue  {
                    print("Added \(totalSteps - oldValue) steps")
                }
            }
        }
    }
    let stepCounter = StepCounter()
    stepCounter.totalSteps = 200
    // About to set totalSteps to 200
    // Added 200 steps
    stepCounter.totalSteps = 360
    // About to set totalSteps to 360
    // Added 160 steps
    stepCounter.totalSteps = 896
    // About to set totalSteps to 896
    // Added 536 steps

print("\nProperty-Observers-willSet-didSet----------------------Ends---------------------\n")