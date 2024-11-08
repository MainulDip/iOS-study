### let/var, type conversion, optional & string interpolation:
```swift
print("Hello World!")

// specifying let/var is mandatory but initial type assignment is optional
let myConstant: String = "CONSTANT"
var myVariable = 42
let typeConversion = String(myVariable)
var optionalType : String? = "Some Values"
let floatN = 3.1416;
let twoDecimalPointFloat = String(format: "%.1f", floatN)


// Multiple assignment
// Multiple assignment
var red, green, blue: Double
var x = 0.0, y = 0.0, z = 0.0
let a = "a", b = "b", c = "c"
var (ab, cd) = (4, 3)
let (abc, bcd) = (4, 3)


let apples = 4, oranges = 3

print("let: \(myConstant) and concatenation: \(myConstant + " " + typeConversion)")
// 3 double quote for multi line string
let quotation = """
I said "I have \(apples) apples."
And then I said "I have \(apples + oranges) pieces of fruit."
"""

print(quotation)
```

### Collections `Array`, `Set` and `Dictionary` || Mutability & Immutability:
 1. `Arrays` are ordered collections of values. Array<Element>, shorthand [Element]
 2. `Sets` are unordered collections of unique values. 
 3. `Dictionaries` are unordered collections of `key-value` associations (JSON in JS)

* - Mutable Collection: Defined with var (variable)
* - Immutable Collection: Defined with let (constant)

To create an empty array or dictionary, use the initializer syntax, ie `[]`, `[:]`
```swift
var emptyArray: [String] = [] // empty array
var emptySet = Set<String>() // empty set
var emptySet2: Set<String> = [] // empty set
var emptyDictionary: [String: Float] = [:] // empty Dictionary, key : value

// type inference not working for empty collections declaration
var fruits: [String] = [] // if type is inferred, it will throw error
fruits = ["Hello", "World!"]
var occupations : [String: Float] = [:] // empty dictionary, have to provide type
var favoriteGenres: Set = ["Rock", "Classical", "Hip hop"] // initializing set with Type: Set and array literal notation
favoriteGenres = [] // deletes all the "set" elements using empty array notation, but it is still "set", not empty array

//If you need an array that is pre-initialized with a fixed number of default values, use the Array(repeating:count:) initializer.
var digitCounts = Array(repeating: 0, count: 10)
print(digitCounts)
// Prints "[0, 0, 0, 0, 0, 0, 0, 0, 0, 0]"
```

### Control Flow, conditionals, loop and nil:
- conditionals : `if/else` | `switch` | ternary `Condition ? "" : ""`
- loop: `for-in` | `while` | `repeat-while`
- Braces around the body are required.
- Parentheses around the condition or loop variable are optional. 

```swift
let individualScores = [75, 43, 103, 87, 12]
var teamScore = 0
for score in individualScores {
    if score > 50 {
        teamScore += 3
    } else {
        teamScore += 1
    }
}
print(teamScore)
// Prints "11"
```
### Dictionary(key:value) Iteration:
`for-in` to iterate over items in a dictionary by providing a pair of names to use for each key-value pair. Dictionaries are an unordered collection, so their keys and values are iterated over in an arbitrary order.
```swift
// Dictionary Iteration
let interestingNumbers = [
    "Prime": [2, 3, 5, 7, 11, -13],
    "Fibonacci": [1, 1, 2, 3, 5, 8],
    "Square": [1, 4, 9, 16, 25],
]
var largest = 0
for (_, numbers) in interestingNumbers {
    for number in numbers {
        if number > largest {
            largest = number
        }
    }
}
print(largest)
// Prints "25"

var smallest: Int?
var smallestV = -77

for (_, values) in interestingNumbers {
    for (index, value) in values.enumerated() {

        if index == 0 && smallest == nil {
            smallest = value
            smallestV = value
        } else {
            if value < smallestV {
                smallestV = value
            }
        }
    }
}
print("Smallest Number is : \(smallestV)")

// Smallest Number is : -13

for (key, value) in interestingNumbers {
    print("\(key) : \(value)")
}
```

### Condition | Comparison Operators | nil | Bool : Boolean || true, false || numeric (0,1) boolean is not allowed:

In an if statement, the conditional must be a Boolean expression—this means that code such as if score { ... } is an error, not an implicit comparison to zero.

* comparison should be of same type String/String, Int/Int, etc.
* comparison operators: == | != | > | < | >= | <=

```swift
// Bool : Boolean || true, false || numeric (0,1) boolean is not allowed
let boolTrue :Bool? = true
var boolOne : Bool? = true
if(boolTrue == boolOne) {
    print("Both are same")
} else {
    print("they are different")
}
```

* nil: swift use `nil` (not `null`)
```swift
var someOptional: String = nil;
```
You can use if and let together to work with values that might be missing

var/let can be initialized inside if/else conditions to work with values that might be missing. These values are represented as optionals. An optional value either contains a value or contains nil to indicate that a value is missing. Write a question mark (?) after the type of a value to mark the value as optional. if not the error will be -> initializer for conditional binding must have Optional type

### String Interpolation & Ternary & Optionals & nil coalescing operator `??`:
There is no `'` single quote in swift. All is double quote. To declare a character, Character type should be used explicitly. Like let a: Character = "a"

```swift
let title: String? = "MD"
let firstname : String? = nil
let lastName : String = "Smith"
let fullN = "\n\( title != nil ? title : "") \(firstname ?? "(No FirstName)") \(lastName ?? "No Lastname")" // nil coalescing `??`
print(fullN)

// optional type casting is for later conditional let/var initialization
print(title) // Optional("MD")
// nil coalescing operator `??`
print(title ?? "Something Else") // MD

// string interpolation using optional check with ternary, nil check & nil coalescing operator
let fullN2 = "\n\(title ?? "(No Title)")\(title != nil ? "." : "") \(firstname ?? "(No FirstName)") \(lastName ?? "No Lastname")"
print(fullN2)
// ternary: let sth = Boolean ? "return if true" : "false" 
```

### Switch:
Switches support any kind of data and a wide variety of comparison operations—they aren't limited to integers and tests for equality.

```swift
// switch statement
import Foundation

let vegetable = "red pepper"
switch vegetable {
    case "celery":
    print("Add some raisins and make ant on a log.")
    case "cucumber", "watercress":
    print("That would make a good tea sandwich.")
    case let x where x.hasSuffix("pepper"):
    print("Is it a spicy \(x)")
    default:
    print("Everything tastes good in soup")
}
// Is it a spicy red pepper
```

### Swift Optionals:
https://www.programiz.com/swift-programming/optionals

```swift
// Optionals wrapped | unwrapped
var someValue:Int? // optional
var someAnotherValue:Int! // optional
print(someValue) // nil
print(someAnotherValue) // none

someValue = 77
someAnotherValue = 7
print(someValue) // Optional(77)
print(someAnotherValue) // some(7)

// using unwarpped !
print(someValue!) // 77
print(someAnotherValue!) // 7

var newOvalue: Int! = 777
print(newOvalue) // some(777)
print(newOvalue!) // 777

var castingOptional: Int?
var castingValue = castingOptional
print(castingValue) // nil

castingOptional = 7777
var castingOptionalSecond = castingOptional!
print(castingOptionalSecond) // 7777
```
### `while(){}` | `repeat{} while(){}` | Loop
NB: condition parenthesis is optional, body braces is required.
```swift
var n = 2
while n < 100 {
    n *= 2
}
print(n)
// Prints "128"

var m = 2
repeat {
    m *= 2
} while m < 100
print(m)
// Prints "128"
```

### range & closed-Range | 0..<4 | 0...4 | 0...4 in for loop:
0..<4 : from 0 to lessthan 4 | Data type => Range<Int>
0...4 : from 0 to equal to 4 | Data type = ClosedRange<Int>
```swift
// range
var total = 0
for i in 0..<4 {
    total += i
}
print(total)
// Prints "6" | 0 + 1 + 2 + 3

var counter = 0
for i in 0...4 {
    counter += i
}
print(counter)
// prints 10 | | 0 + 1 + 2 + 3 + 4
```

### Functions:
- `func` to declare a function
- `->` to separate the parameter names and types from the function's return type.
```swift
func greet(person: String, day: String) -> String {
    return "Hello \(person), today is \(day)."
}
greet(person: "Bob", day: "Tuesday")
```
### Functions parameter labeling:
By default, functions use their parameter names as labels for their arguments. provide something before parameter names to make it label. Use "_" to declare no label. 

If label is specified, it is required to provide "label : parameter-value" while calling.
```swift
// function parameter labeling
func hellotest(_ firstname: String, ln lastname: String) -> String {
    return "Hello \(firstname) \(lastname)"
}
print(hellotest("FirstN", ln: "LastN"))
```

### Tuple:
https://www.programiz.com/swift-programming/tuples

In Swift, a tuple is a group of different values. And, each value inside a tuple can be of different data types.

tuple can be simple values or named values. also tuple can store another tuple or dictionary/ies

- Only tuple's dictionary elements can be added or removed. Other than tuple's member size/count is fixed so new elements cannot be added or removed.
- But value/member can be edited

```swift
// Tuples:
var unNamedTuple = ("MackBook", 1099.99)
var namedTuple = (product: "AirPod", varsion: 1234)
var tupleNestedDictionary = (productsTuple: (laptop: 4, desktop: 3), productsDictionary: ["Montery": 12, "Big Sur": 11, "Catalina": 10.15], ("Mojave", "High Sierra", "Sierra") )

print(unNamedTuple.0) // Mackbook
print(namedTuple.product) // Airpod
print(tupleNestedDictionary.productsTuple.laptop) // 4
print(tupleNestedDictionary.productsDictionary) // ["Catalina": 10.15, "Big Sur": 11.0, "Montery": 12.0]
print(tupleNestedDictionary.productsDictionary["Catalina"]) // Optional(10.15)
print(tupleNestedDictionary.productsDictionary["Catalina"]!) // 10.15

// Only tuple's dictionary elements can be added or removed. Other than tuple's member size/count is fixed so new elements cannot be added or removed.
// But value/member can be edited

// adding element into tuple's dictionary
tupleNestedDictionary.productsDictionary["Mojave"] = 10.14
// removing element from tuple's dictionary
tupleNestedDictionary.productsDictionary["Catalina"] = nil

print(tupleNestedDictionary.productsDictionary) // ["Mojave": 10.140000000000001, "Big Sur": 11.0, "Montery": 12.0]
print(tupleNestedDictionary.productsDictionary["Mojave"]!) // 10.14
```

### Function returning compound values as Tuple | list/array as argument:
Function can return tuple `(x: Type, y: Type, z: Type)`and also take array as arguments like `[Type]`
```swift
// array arguments and `tuple` returning
func calculateStatistics(scores: [Int]) -> (min: Int, max: Int, sum: Int) {
    var min = scores[0]
    var max = scores[0]
    var sum = 0

    for score in scores {
        if score > max {
            max = score
        } else if score < min {
            min = score
        }
        sum += score
    }

    return (min, max, sum)
}
let statistics = calculateStatistics(scores: [5, 3, 100, 3, 9])
print(statistics.sum)
// Prints "120"
print(statistics.2)
// Prints "120"
```

### Nested Fn | Fn returning Fn or taking Function as argument | Fn are first-class type:

* Nested Functions:
Nested functions have access to variables that were declared in the outer function.
```swift
func returnFifteen() -> Int {
    var y = 10
    func add() {
        y += 5
    }
    add()
    return y
}
returnFifteen()
```

* Function Returning Another Function:

In Swift, functions are first-class, that means, a function can return another function and call by reference after.
```swift
func makeIncrementer() -> ((Int) -> Int) {
    func addOne(number: Int) -> Int {
        return 1 + number
    }
    return addOne
}
var increment = makeIncrementer()
increment(7)
```

### Closure Functions/Fn | Injecting fn in another fn's parameter:
A closure function can take another function as one of its arguments, which can be injected later. It is also a nested fn in Swift.

```swift
// closure signature : (arg1: type, arg2: type)-> return-type
{(parameters) -> return-type in closure-body }
// Note: Calling another method from a closure needs the self keyword explicitly
```

- closures: blocks of code that can be called later. 
The code in a closure has access to things like variables and functions that were available in the scope where the closure was created, even if the closure is in a different scope when it’s executed.

Closures in Swift are similar to blocks in C and Objective-C and to lambdas in other programming languages.

* Closure Expression Syntax: {(parameters) -> return-type in body/statement/return  }

```swift
func hasAnyMatches(list: [Int], condition: (Int) -> Bool) -> Bool {
    for item in list {
        if condition(item) {
            return true
        }
    }
    return false
}
func lessThanTen(number: Int) -> Bool {
    return number < 10
}
var numbers = [20, 19, 7, 12]
hasAnyMatches(list: numbers, condition: lessThanTen)
```

### Closure {} braces/anonymous and named function style:
Closure can be written without a name by surrounding code with braces `{}`. Use "in"to separate the arguments and return type from the body.
```swift
// Closure using {} braces/anonymous and "named function" both style
func countTotal(list: [Int], math: (Int, Int) -> Int) -> Int {
    var total = 0;
    for item in list {
        total = math(total, item)
    }
    return total
}
let numberList = [21, 19, 7, 12]

// closure {} braces/anonymous style
// "in" is used to separate the arguments and return type from body
var totalMath = countTotal(list: numberList, math: { (old: Int, new: Int) -> Int in
    return old + new
})
print("totalMath: \(totalMath)")

// closure "named function" style | define the closure
func calculation (old: Int, new: Int) -> Int {
    return old + new
}
var getTheTotal = countTotal(list: numberList, math: calculation)
print("Getting total from named closure: \(getTheTotal)")
```
### closure `trailing`, numbered arguments `$0` `$1`, multiple closure labeling, `lazy/non var closure` call:
Multiple Closures labeling: omit the argument label for the first trailing closure and provide label the remaining trailing closures.
`lazy/non var closure` call: when a closure are stored in a lazy (or no-lazy) variable, it needs to be called/invoked in definition like `{}()`
```swift
func loadPicture(from server: Server, completion: (Picture) -> Void, onFailure: () -> Void) {
    if let picture = download("photo.jpg", from: server) {
        completion(picture)
    } else {
        onFailure()
    }
}

loadPicture(from: someServer) { picture in
    someView.currentPicture = picture
} onFailure: {
    print("Couldn't download the next picture.")
}

// lazy/non var closure | closure storage
struct L {
    lazy var a: Int = { print("Setting A"); return 5}(); // will be called when first accessed
    var b: Int = { print("Setting B"); return 5 }() // will be called immediately when the struct will be initialized
}
```

### Closure/Function's Reference Type and Capturing Values:
In Swift, the simplest form of a closure that can capture values is a nested function, written within the body of another function. A nested function can capture any of its outer function’s arguments and can also capture any constants and variables defined within the outer function.

```swift
func makeIncrementer(forIncrement amount: Int) -> () -> Void {
    var runningTotal = 0
    func incrementer() -> Void {
        runningTotal += amount
        print(runningTotal)
    }
    return incrementer
}

let incrementByTen = makeIncrementer(forIncrement: 10)
incrementByTen()
// prints a value of 10
incrementByTen()
// prints a value of 20
incrementByTen()
// prints a value of 30

let incrementBySeven = makeIncrementer(forIncrement: 7)
incrementBySeven()
// prints a value of 7
incrementBySeven()
// prints a value of 14
```

### Closure ARC (Automatic Reference Counting)

Docs: https://docs.swift.org/swift-book/LanguageGuide/AutomaticReferenceCounting.html.......

### Attributes | @attributes | @attributes(params)
https://docs.swift.org/swift-book/ReferenceManual/Attributes.html