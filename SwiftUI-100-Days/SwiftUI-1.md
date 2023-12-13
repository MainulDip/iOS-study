### Stop content from scrolling beyond top Safe Ares:
- Put the content inside of a NavigationStack and add the .navigationTitle("") on the content's container
```swift
struct ContentView: View {
    var body: some View {
        
        NavigationStack {
            Form {
                Section {
                    Text("Hello, World")
                }
                Section {
                    Text("Something")
                }
            }
            .navigationTitle("SwiftUI")
            .navigationBarTitleDisplayMode(.inline) // change the large font of the Navigation Title to small
        }
    }
}
```

### @State and Two Way Binding ($):
To be able to get a mutable variable `@State` property-wrapper (annotation).

It's said that `SwiftUI’s views are a function of their state`. So if state change the view will be updated.

`$ Two Way Binding` (Binding<Type>) - is used to change/mutate/read (Read/Write) the declared state variable inside and outside of the body property at the same time. using two way binding, the view is informed about the change on a defined State. Is done by `$stateName` inside of a body::view and declaration of @State var.
```swift
struct ContentView: View {

    let students = ["Harry", "Hermione", "Ron"]
    @State private var selectedStudent = "Harry"
    
    @State private var tapCount = 0
    
    @State private var name = ""
    
    var body: some View {
        
        NavigationStack {
            Form {
                TextField("Enter Your Name", text: $name) // Binding<Type> to Read/Write @State at the same time
                Text("Hello, World")
            }
            .navigationTitle("SwiftUI")
            .navigationBarTitleDisplayMode(.inline)
            
            // this tapCount is only reding the declared @State, not modifying/writing to it
            Button("Tap Count: \(tapCount)") {
                self.tapCount += 1
            }
        }
    }
}
```

### Picker and ForEach with id: KeyPath<T> as (\Class.PropertyName
):
https://docs.swift.org/swift-book/documentation/the-swift-programming-language/expressions/#Key-Path-Expression
```swift
struct ContentView: View {
    
    let students = ["Harry", "Hermione", "Ron"]
    @State private var selectedStudent = "Harry"
    
    var body: some View {
        
        // using 2 way binding on $selectedStudent as bot read/write
        Picker("Select your Student", selection: $selectedStudent) {
            ForEach(students, id: \.self) { // \.self the the KeyPath for using key/id which refers to the students array's item 
                Text($0)
            }
        }      
    }
}
```

### Local to get User's Settings:
Locale is a massive struct built into iOS that is responsible for storing all the user’s region settings – what calendar they use, how they separate thousands digits in numbers, whether they use the metric system, and more.
Also, if not set, we can set default
```swift
TextField("Amount", value: $checkAmount, format: .currency(code: Locale.current.currency?.identifier ?? "USD"))
.keyboardType(.decimalPad) // .numberPad and .decimalPad will make the popup keyboard number only mode
```