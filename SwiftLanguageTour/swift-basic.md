## Content Overview:

### let, var, type, type conversion, optional type, string interpolation:
```swift
print("Hello World!")

// specifying let/var is mandatory but initial type assaignment is optional
let myConstant: String = "CONSTANT"
var myVariable = 42
let typeConversion = String(myVariable)
var optionalType : String? = "Some Values"


// Multiple assaignment
var red, green, blue: Double
var x = 0.0, y = 0.0, z = 0.0
let a = "a", b = "b", c = "c"
var (ab, cd) = (4, 3)
let (abc, bcd) = (4, 3)


let apples = 4, oranges = 3

print("let: \(myConstant) and concatination: \(myConstant + " " + typeConversion)")
// 3 double quote for multi line string
let quotation = """
I said "I have \(apples) apples."
And then I said "I have \(apples + oranges) pieces of fruit."
"""

print(quotation)
```

### Collections || Array, Set and Dictionary || Mutability & Immutability:
 1. Arrays are ordered collections of values. Array<Element>, shorthand [Element]
 2. Sets are unordered collections of unique values. 
 3. Dictionaries are unordered collections of key-value associations (JSON in JS)

* - Mutable Collection: Defiened with var (variable)
* - Immutable Collection: Defiened with let (constant)

To create an empty array or dictionary, use the initializer syntax
```swift
var emptyArray: [String] = [] // rmpty array
var emptySet = Set<String>() // empty set
var emptySet2: Set<String> = [] // empty set
var emptyDictionary: [String: Float] = [:] // empty Dictionary, key : value

// type inferration not working for collections
var fruits: [String] = [] // if type is infreed, it will throw error
fruits = ["Hello", "World!"]
var occupations : [String: Float] = [:] // empty dictionary, have to provide type
var favoriteGenres: Set = ["Rock", "Classical", "Hip hop"] // initializing set with Type: Set and array literal notation
favoriteGenres = [] // deletes all the "set" elements using empty array notration, but it is still "set", not empty array
```

### Control Flow, conditionals, loop and nil:
- conditionals : if | switch
- loop: for-in | while | repeat-while
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

* nil:
```swift

```
You can use if and let together to work with values that might be missing.

var/let can be initialized inside if/else conditions to work with values that might be missing. These values are represented as optionals. An optional value either contains a value or contains nil to indicate that a value is missing. Write a question mark (?) after the type of a value to mark the value as optional. if not the error will be -> initializer for conditional binding must have Optional type

### String Interpolation & Ternary & Optionals
```swift
let title: String? = "MD"
let firstname : String? = nil
let lastName : String = "Smith"
let fullN = "\n\( title != nil ? title : "") \(firstname ?? "(No FirstName)") \(lastName ?? "No Lastname")"
print(fullN)

// optional type casting is for later conditinal let/var initialization
print(title) // Optional("MD")
print(title ?? "Something Else") // MD

// string interpolation using optional check with ternary
let fullN2 = "\n\(title ?? "(No Title)")\(title != nil ? "." : "") \(firstname ?? "(No FirstName)") \(lastName ?? "No Lastname")"
print(fullN2)
```

### Switch:
Switches support any kind of data and a wide variety of comparison operations—they aren’t limited to integers and tests for equality.

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

### Dictionary(key:value) Iteration:
for-in to iterate over items in a dictionary by providing a pair of names to use for each key-value pair. Dictionaries are an unordered collection, so their keys and values are iterated over in an arbitrary order.
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