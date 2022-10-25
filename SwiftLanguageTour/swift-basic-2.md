### Optionals:
```swift
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
```

* If Statements and Forced Unwrapping:
```swift
// Only apply Forced Unwrapping "value!" when you're sure, as it will throw error on "nil"
if convertNumToInt != nil {
    print("convertNumToInt contains some integer value of \(convertNumToInt!).")
}

print("\nIf Statements and Forced Unwrapping Ends:\n")
```

* Optional Binding:
```swift
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
```

* Implicitly Unwrapped Optionals:
```swift
/**
 * Implicitly Unwrapped Optionals
 * it’s clear from a program’s structure that an optional will always have a value
 * to define place an exclamation point after the optional’s type when declared
 * The primary use of implicitly unwrapped optionals in Swift is during class initialization
*/
    
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
```

Note: Constants and variables created with optional binding in an if statement are available only within the body of the if statement. But if created with "guard" statement, constants and variables are available in the lines of code that follow the guard statement

* multiple optional bindings and boolean condition in a single if statement
```swift
// The following if statements are equivalent

if let firstNumber = Int("4"), let secondNumber = Int("42"), firstNumber < secondNumber && secondNumber < 100 {
    print("\(firstNumber) < \(secondNumber) < 100")
}
// Prints "4 < 42 < 100"

if let firstNumber = Int("4") {
    if let secondNumber = Int("42") {
        if firstNumber < secondNumber && secondNumber < 100 {
            print("\(firstNumber) < \(secondNumber) < 100")
        }
    }
}
// Prints "4 < 42 < 100"
```
Implicitly Unwrapped Optionals:
https://docs.swift.org/swift-book/LanguageGuide/TheBasics.html#ID334


### guard Statement | another kind of if:
```swift
/**
 * guard Statement
 * like an if statement, executes statements depending on the Boolean value of an expression.
 * requires "esle" clause unlike if (where "else" is optional)
*/
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
```

### Error Handling:
A function indicates that it can throw an error by including the throws keyword in its declaration. When you call a function that can throw an error, you prepend the try keyword to the expression.

Swift automatically propagates errors out of their current scope until they’re handled by a catch clause.

```swift
func canThrowAnError() throws {
    // this function may or may not throw an error
}

do {
    try canThrowAnError()
    // no error was thrown
} catch {
    // an error was thrown
}
```

### Assertions and Preconditions:
* Assertions:
```swift
let age = -3
assert(age >= 0, "A person's age can't be less than zero.")
// This assertion fails because -3 isn't >= 0.
```

* Preconditions:
```swift
// In the implementation of a subscript...
precondition(index > 0, "Index must be greater than zero.")
```

### Properties

* Stored Properties

* lazy property:

* computed property:

* Read-Only Computed Properties:
### Methods:

### Subscripts
Classes, structures, and enumerations can define subscripts, which are shortcuts for accessing the member elements of a collection, list, or sequence. 

```swift
/*
* Basic Subscripts
* define in class/struct using "subscript (param: type) -> return-type { body }"
* call on newInstance[value]
*/

struct TimesTable {
    let multiplier: Int
    subscript(index: Int) -> Int {
        return multiplier * index
    }
}
let threeTimesTable = TimesTable(multiplier: 3)
print("seven times three is \(threeTimesTable[7])") // prints "seven times three is 21"
```


### Generics: