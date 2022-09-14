## Content Overview:

### let, var, type, type conversion, string interpolation:
```swift
print("Hello World!")

// specifying let/var is mandatory but initial type assaignment is optional
let myConstant: String = "CONSTANT"
var myVariable = 42
let typeConversion = String(myVariable)


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

### Array, Set and Dictionary:
Arrays are ordered collections of values. Sets are unordered collections of unique values. Dictionaries are unordered collections of key-value associations

To create an empty array or dictionary, use the initializer syntax
```swift
let emptyArray: [String] = [] // rmpty array
let emptyDictionary: [String: Float] = [:] // empty Dictionary

// type inferred
fruits = [] // empty array
occupations = [:] // empty dictionary
```