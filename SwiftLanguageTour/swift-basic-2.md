### Optionals:
If Statements and Forced Unwrapping:
Optional Binding:


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

### guard Statement | another king of if:
