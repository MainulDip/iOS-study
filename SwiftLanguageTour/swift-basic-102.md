### Optionals | ? | ! | ?? (nil coalescing operator):
```swift
let cNum = "1234"
let cStr = "Something"
let convertNumToInt = Int(cNum) // implicit type is "Int?"
let convertStrToInt = Int(cStr)

// Int(value) will return the number if conversion is successful, or nil if failed. Hence the type "Int?"

let convertNumToIntFoptional: Int? = Int(cNum) // explicit type is redundant here, because Int(v) will implicitly cast to "Int?"
let convertNumToIntUnwrapped = Int(cNum)! // but throw error if forced unwrapped is applied to "nil" or conversion is not successful 

print(convertNumToInt) // Optional(1234)
print(convertStrToInt) // nil
// print(convertNumToInt as Any) // to silence warning

print(convertNumToIntFoptional) // Optional(1234)
print(convertNumToIntFoptional!) // 1234
print(convertNumToIntUnwrapped ?? "convertNumToIntUnwrapped is nil") // 1234
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
    print ("The string \"\(cNum)\" is convertible to Integer : \(convertedInt) ")
} else {
    print("\"\(cNum)\" is not convertible to Integer value")
}

print("\nOptional Bindings Ends:\n")
```

* Implicitly Unwrapped Optionals:
```swift
/**
 * Implicitly Unwrapped Optionals
 * it’s way to make it clear from a program’s structure that an optional will always have a value 
 * to define `place an exclamation` point after the optional’s type when declared
 * The primary use of implicitly unwrapped optionals in Swift is during class initialization
*/
    
var assumedString: String!
print(assumedString)// Prints "none"
print("assumedString == nil : \(assumedString == nil)") // Prints "assumedString == nil : true"
assumedString = "An implicitly unwrapped optional string."
print(assumedString) // Prints "some("An implicitly unwrapped optional string.")"
print(assumedString!) // Prints "An implicitly unwrapped optional string."

let implicitString: String = assumedString // no need for an exclamation point
print(implicitString) // Prints "An implicitly unwrapped optional string."


// Regular Optional Unwrapping
let possibleString: String? = "An optional string."
let forcedString: String = possibleString! // requires an exclamation point
print("forcedString: \(forcedString)") // Prints "forcedString: An optional string."
```

Note: Constants and variables created with optional binding in an if statement are available only within the body of the if statement. But if created with "guard" statement, constants and variables are available in the lines of code that follow the guard statement....

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


### guard Statement | `guard let x = y else {z}`:
like an if statement, guard statement will populate the constant with the value. Guard requires "else" clause unlike if (where "else" is optional)
```swift
/**
 * guard Statement
 * like an if statement, executes statements depending on the Boolean value of an expression.
 * requires "else" clause unlike if (where "else" is optional)
*/
func greet(person: [String: String]) {
    // if the dictionary passed in the argument contains `name` property, store that in the variable, otherwise store the else block.
    // so we know the name property will never be empty when used
    guard let name = person["name"] else {
        print("No name is applied, nothing will be called after this return underneath")
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
// Prints "No name is applied, nothing will be called after this return underneath"

greet(person: ["name": "Jane", "location": "Cupertino"])
// Prints "Hello Jane!"
// Prints "I hope the weather is nice in Cupertino."

greet(person: [:])
// Print "No name is applied, nothing will be called after this return underneath"
```

### Error Handling:
A function indicates that it can throw an error by including the throws keyword in its declaration. When you call a function that can throw an error, you prepend the try keyword to the expression....

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

### Generics:
Generic Function `func fnName<T: Decodable> (param: URL) -> [T] {}` here the `T` will accept anything that confronts to Decodable protocol and the fn will return array of T as `[T]`
```swift

let dataFilePath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first?.appendingPathComponent("Item.plist")

override func viewDidLoad() {
    super.viewDidLoad()
    
    // get local data and update the local list using generics
    if let url = dataFilePath {
        // this do automatic type inference
        // itemArray = decodeItemDataGenerics(filePath: url)

        // the type of the generic will be captured form sth: [Item]
        let sth: [Item] = decodeItemDataGenerics(filePath: url)
        itemArray = sth
    }
}

// regular function
func decodeItemData (filePath: URL) {
    let decoder = PropertyListDecoder()
    
    do {
        let data = try Data(contentsOf: filePath)
        itemArray = try decoder.decode([Item].self, from: data)
    } catch {
        print("Decoder Error: ", error)
    }
}

// over engineering using generics
func decodeItemDataGenerics<T: Decodable> (filePath: URL) -> [T] {
    let decoder = PropertyListDecoder()
    var storedItemArray: [T] = []
    
    do {
        let data = try Data(contentsOf: filePath)
        storedItemArray = try decoder.decode([T].self, from: data)
    } catch {
        print("Decoder Error: ", error)
    }
    
    return storedItemArray
}
```
### Asynchronous Operations | async/await:
- `async` before function definition
- `await` before function evocation
- Use `async let` to call an asynchronous function, letting it run in parallel with other asynchronous code. When you use the value it returns, write await.
- Use `Task{}` to call asynchronous functions from synchronous code, without waiting for them to return
```swift
func fetchUserID(from server: String) async -> Int {
    if server == "primary" {
        return 97
    }
    return 501
}

func fetchUsername(from server: String) async -> String {
    let userID = await fetchUserID(from: server)
    if userID == 501 {
        return "John Appleseed"
    }
    return "Guest"
}

func connectUser(to server: String) async {
    async let userID = fetchUserID(from: server)
    async let username = fetchUsername(from: server)
    let greeting = await "Hello \(username), user ID \(userID)"
    print(greeting)
}

Task {
    await connectUser(to: "primary")
}
// Prints "Hello Guest, user ID 97"

```