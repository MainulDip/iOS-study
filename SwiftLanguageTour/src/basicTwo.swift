/**
 * Optionals in depth
*/
let cNum = "1234"
let cStr = "Something"
let convertNumToInt = Int(cNum) // implicit type is "Int?"
let convertStrToInt = Int(cStr)

// Int(value) will return the number if conversion is successful, or nil if faild. Hence the type "Int?"

let convertNumToIntFoptional: Int? = Int(cNum) // explicit type is redundaunt here, because Int(v) will implicitly cast to "Int?"
let convertNumToIntUnwrapped = Int(cNum)! // but throw error if forced unwrapped is applied to "nil" or conversion is not successful 

print(convertNumToInt) // Optional(1234)
print(convertStrToInt) // nil
// print(convertNumToInt as Any) // to silence warning

print(convertNumToIntFoptional) // Optional(1234)
print(convertNumToIntFoptional!) // 1234
print(convertNumToIntUnwrapped) // 1234


/**
 * If Statements and Forced Unwrapping
*/
print("\nIf Statements and Forced Unwrapping Starts:\n")

// Only apply Forced Unwrapping "value!" when you're sure, as it will throw error on "nil"
if convertNumToInt != nil {
    print("convertNumToInt contains some integer value of \(convertNumToInt!).")
}

print("\nIf Statements and Forced Unwrapping Ends:\n")

/**
 * Optional Binding
 * this can be used to find out whether an optional contains a value, and if so, to make that value available as a temporary constant or variable.
*/
print("\nOptional Binding Starts:\n")

if let convertedInt = Int(cNum) {
    print ("The string \"\(cNum)\" is covertable to Integer : \(convertedInt) ")
} else {
    print("\"\(cNum)\" is not covertable to Integer value")
}

print("\nOptional Bindings Ends:\n")

/**
 * Implicitly Unwrapped Optionals
 * it’s clear from a program’s structure that an optional will always have a value
 * to define place an exclamation point after the optional’s type when declared
 * The primary use of implicitly unwrapped optionals in Swift is during class initialization
*/
print("\nImplicitly Unwrapped Optionals Starts:\n")
    
let possibleString: String? = "An optional string."
let forcedString: String = possibleString! // requires an exclamation point
print("forcedString: \(forcedString)") // Prints "forcedString: An optional string."

var assumedString: String!
print(assumedString)// Prints "none"
print("assumedString == nil : \(assumedString == nil)") // Prints "assumedString == nil : true"
assumedString = "An implicitly unwrapped optional string."
print(assumedString) // Prints "some("An implicitly unwrapped optional string.")"
print(assumedString!) // Prints "An implicitly unwrapped optional string."

let implicitString: String = assumedString // no need for an exclamation point
print(implicitString) // Prints "An implicitly unwrapped optional string."

print("\nImplicitly Unwrapped Optionals Ends:\n")

/**
 * guard Statement
 * like an if statement, executes statements depending on the Boolean value of an expression.
 * requires "esle" clause unlike if (where "else" is optional)
*/

print("\nguard Statement console starts:\n")

func greet(person: [String: String]) {
    guard let name = person["name"] else {
        print("No name is applied, nothing will be called after this return underneth")
        return
    }

    print("Hello \(name)!")

    guard let location = person["location"] else {
        print("I hope the weather is nice near you.")
        return
    }

    print("I hope the weather is nice in \(location).")
}

greet(person: ["name": "John"])
// Prints "Hello John!"
// Prints "I hope the weather is nice near you."

greet(person: ["location": "Cupertino"])
// Prints "No name is applied, nothing will be called after this return underneth"

greet(person: ["name": "Jane", "location": "Cupertino"])
// Prints "Hello Jane!"
// Prints "I hope the weather is nice in Cupertino."

greet(person: [:])
// Print "No name is applied, nothing will be called after this return underneth"

print("\nguard Statement console Ends:\n")