### KeyPath and KeyPath Expression:
KeyPath is a reference to an actual property instead of a value. It is used as dynamic reference of a property in class/struct. printing a keypath will simply print `\Class.prop`. but when used with an instance using keyPath subscript like `instance[keyPath: \Class.prop]`, it will print the value.

A key-path expression (`\<#type name#>.<#path#>`) refers to a property or subscript of a type/class/struct. You use key-path expressions in dynamic programming tasks, such as key-value observing.......

At compile time, a key-path expression is replaced by an instance of the KeyPath class.......
https://docs.swift.org/swift-book/documentation/the-swift-programming-language/expressions/#Key-Path-Expression.......
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
### Double + Trailing Closure/Lambda :
Multiple closure can be called using trailing lambda syntax, but after first, every lambda should add `label`.
```swift
var body: some View {
    Button("Show Sheet") {
        showingSheet.toggle()
    }
    .sheet(isPresented: $showingSheet){ // onDismiss closure
        print("Calling onDismiss")
    } content : { // content closure
        SecondView(name: "@twostraws")
    }
}
```

see: https://www.hackingwithswift.com/swift/5.3/multiple-trailing-closures


### More on KeyPath and KeyPath Expression `\`:
The most common way to make an instance of this type is by using a key-path expression like \SomeClass.someProperty. And the 

```swift
struct SomeStructure {
    var someValue: Int
}


let s = SomeStructure(someValue: 12)
let pathToProperty = \SomeStructure.someValue

/* Using keyPath Subscript which is available on all types */
let value = s[keyPath: pathToProperty]
// value is 12
```

Docs: https://developer.apple.com/documentation/swift/keypath
* Docs: https://docs.swift.org/swift-book/documentation/the-swift-programming-language/expressions/#Key-Path-Expression


### @Environment and Dismiss a View:
Use the Environment property wrapper to read a value (but cannot set) stored in a view’s environment. Indicate the value to read using an `EnvironmentValues` key path in the property declaration. Signature `@Environment(\EnvironmentValues.prop) var variableName: Type`

All the available keyPath for using in @Environment are here -> https://developer.apple.com/documentation/swiftui/environmentvalues

```swift
/**
* Showing another view conditionally using Sheets
* And also dismissing that using @Environment Property wrapper
*/

struct SheetsConditional: View {
    
    @State private var showingSheet = false
    
    var body: some View {
        Button("Show Sheet") {
            showingSheet.toggle()
        }
        .sheet(isPresented: $showingSheet) {
            SecondView(name: "@twostraws")
        }
    }
}

struct SecondView: View {
    
    // using @Environment wrapper for self destruction (this view)
    @Environment(\EnvironmentValues.dismiss) var dismiss
    
    // var dismissActionKeyPath: KeyPath<EnvironmentValues, DismissAction> = \EnvironmentValues.dismiss
    
    let name: String
    
    var body: some View {
        VStack {
            Text("Hello, \(name)!")
            Button("Dismiss") {
                dismiss()
            }
        }
    }
}
```
If the value changes, SwiftUI updates any parts of your view that depend on the value. 

@Environment Docs: https://developer.apple.com/documentation/swiftui/environment
EnvironmentValue Docs: https://developer.apple.com/documentation/swiftui/environmentvalues.......

### `@ViewBuilder` and `@resultBuilder`:
@ViewBuilder (attribute/annotation) is one of the few result builders available as built API in SwiftUI.