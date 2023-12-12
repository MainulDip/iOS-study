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

