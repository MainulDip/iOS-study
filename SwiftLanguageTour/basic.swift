print("Hello World!")

// let, var, type, type conversion, string interpolation
// specifying let/var is mandatory but initial type assaignment is optionals
let myConstant: String = "CONSTANT"
var myVariable = 42
let typeConversion = String(myVariable)


// Multiple var/let assaignments
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

// while | repeat while
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



// functions
func greet(person: String, day: String) -> String {
    return "Hello \(person), today is \(day)."
}
print(greet(person: "Bob", day: "Tuesday"))

// function parameter labeling
func hellotest(_ firstname: String, ln lastname: String) -> String {
    return "Hello \(firstname) \(lastname)"
}
print(hellotest("FirstN", ln: "LastN"))


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

// Only tuple's dictionary elements can be added or removed. Other than tuple's size/count is fixed so new elements cannot be added or removed.
// But, old values can be modified

// adding element into tuple's dictionary
tupleNestedDictionary.productsDictionary["Mojave"] = 10.14
// removing element from tuple's dictionary
tupleNestedDictionary.productsDictionary["Catalina"] = nil

print(tupleNestedDictionary.productsDictionary) // ["Mojave": 10.140000000000001, "Big Sur": 11.0, "Montery": 12.0]
print(tupleNestedDictionary.productsDictionary["Mojave"]!) // 10.14

// Function returning tuple
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
print(statistics)
// Prints "(min: 3, max: 100, sum: 120)"
