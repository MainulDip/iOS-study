print("Hello World!")

// let, var, type, type conversion, string interpolation
// specifying let/var is mandatory but initial type assaignment is optional
let myConstant: String = "CONSTANT"
var myVariable = 42
let typeConversion = String(myVariable)


// Multiple var/let assaignment
var red, green, blue: Double
var x = 0.0, y = 0.0, z = 0.0
let a = "a", b = "b", c = "c"
var (ab, cd) = (4, 3)
// let (abc, bcd) = (4, 3)


let apples = 4, oranges = 3

print("let: \(myConstant) and concatination: \(myConstant + " " + typeConversion)")
// 3 double quote for multi line string
let quotation = """
I said "I have \(apples) apples."
And then I said "I have \(apples + oranges) pieces of fruit."
"""

print(quotation)

// Collections
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

// Conditionals and Loops:

// - conditionals : if | switch
// - loop: for-in | while | repeat-while
// - Braces around the body are required.
// - Parentheses around the condition or loop variable are optional.

let individualScores = [75, 43, 103, 87, 12]
var teamScore = 0
for score in individualScores {
    if score > 50 {  // if condition should be Boolean
        teamScore += 3
    } else {
        teamScore += 1
    }
}
print("\nConditionals and Loops:")
print("teamScore: \(teamScore)")


// Bool : Boolean || true, false || numeric (0,1) boolean is not allowed
let boolTrue = true
var boolOne = 1
if(boolTrue == boolOne) {
    print("Both are same")
} else {
    print("they are different")
}
