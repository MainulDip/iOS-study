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

// type inferred
fruits = [] // empty array
occupations = [:] // empty dictionary
var favoriteGenres: Set = ["Rock", "Classical", "Hip hop"]
```

### Control Flow, conditionals, loop and nil:
Use if and switch to make conditionals, and use for-in, while, and repeat-while to make loops. Parentheses around the condition or loop variable are optional. Braces around the body are required.

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

In an if statement, the conditional must be a Boolean expression—this means that code such as if score { ... } is an error, not an implicit comparison to zero.

You can use if and let together to work with values that might be missing. These values are represented as optionals. An optional value either contains a value or contains nil to indicate that a value is missing. Write a question mark (?) after the type of a value to mark the value as optional.