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
let boolTrue: Bool? = true
var boolTrue2: Bool? = true
if(boolTrue == boolTrue2) {
    print("Both are same")
} else {
    print("they are different")
}

// Testing nil | Optional nullable
var optionalString: String? = "Hello"
print(optionalString == nil)
// Prints "false"

var optionalNameNil: String?
var nameSome: String? = "Somenaming" // opting "?" optional type will throw an error
var greeting = "Hello!"
if let name = optionalNameNil {
    greeting = "Hello, \(name)"
    print("greeting + name : \(greeting)")
} else if var name = nameSome { // var is also possible
    print("else if block : \(name)") // this will print at the end
} else {
    print("name is nil") // this will print if nameSome is also nil, but it is not
}

let nickname: String? = nil
let fullName: String = "John Appleseed"
let informalGreeting = "Hi \(nickname ?? fullName)"
print(informalGreeting)

let title: String? = "MD"
let firstname : String? = nil
let lastName : String = "Smith"
let fullN = "\n\( title != nil ? title : "") \(firstname ?? "(No FirstName)") \(lastName ?? "No Lastname")"
print(fullN) // Optional("MD") (No FirstName) Smith  

// its not expected practice to use optional typed var/let straight

// string interpolation using optional check with ternary
let fullN2 = "\n\(title ?? "(No Title)")\(title != nil ? "." : "") \(firstname ?? "(No FirstName)") \(lastName ?? "No Lastname")"
print(fullN2) // MD. (No FirstName) Smith

// optional type casting is for late conditinal let/var initialization
print(title) // Optional("MD")
print(title ?? "Something Else") // MD

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


