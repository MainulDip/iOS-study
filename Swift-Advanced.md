### KeyPath Expression:
A key-path expression (`\<#type name#>.<#path#>`) refers to a property or subscript of a type. You use key-path expressions in dynamic programming tasks, such as key-value observing. The path consists of property names, subscripts, optional-chaining expressions, and forced unwrapping expressions.

At compile time, a key-path expression is replaced by an instance of the KeyPath class.
https://docs.swift.org/swift-book/documentation/the-swift-programming-language/expressions/#Key-Path-Expression
```swift
struct SomeStructure {
    var someValue: Int
}

let s = SomeStructure(someValue: 12)
let pathToProperty = \SomeStructure.someValue

let value = s[keyPath: pathToProperty]
// value is 12
```
### Swift SubScript:
Subscripts enable you to query instances of a type by writing one or more values in square brackets `someInstance["param1", "param2"]` after the instance name. Their syntax is similar to both instance method syntax and computed property syntax. You write subscript definitions with the subscript keyword, and specify one or more input parameters and a return type, in the same way as instance methods. 
Docs: https://docs.swift.org/swift-book/documentation/the-swift-programming-language/subscripts/
```swift
struct TimesTable {
    let multiplier: Int
    subscript(index: Int) -> Int {
        return multiplier * index
    }
}
let threeTimesTable = TimesTable(multiplier: 4)
print("six times three is \(threeTimesTable[6])")
// Prints "six times three is 24"
```