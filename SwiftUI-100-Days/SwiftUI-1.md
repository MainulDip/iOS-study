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

### @FocusState:
A property wrapper type that can read and write a value that SwiftUI updates as the placement of focus within the scene changes.
https://developer.apple.com/documentation/swiftui/focusstate
```swift
struct ContentView: View {
    
    @State private var checkAmount = 0.0
    
    @FocusState private var amountIsFocused: Bool
    
    var body: some View {
        NavigationStack {
            Form {
                Section {
                    TextField("Amount", value: $checkAmount, format: .currency(code: Locale.current.currency?.identifier ?? "USD"))
                        .keyboardType(.decimalPad)
                        .focused($amountIsFocused) // this will make the @FocusState True
                }
            }
            .toolbar { // this will show a done button on the top-right corner of the screen on the selected view (EditText this case) while on focused, and onClick will remove the focus and hide the soft keyboard.
                if amountIsFocused {
                    Button("Done") {
                        amountIsFocused = false
                    }
                }
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

### @/PropertyWrappers/Annotations commonly used:
`@AppStorage` reads and writes values from UserDefaults. This owns its data. More info.
`@Binding` refers to value type data owned by a different view. Changing the binding locally changes the remote data too. This does not own its data. More info.
`@Environment` lets us read data from the system, such as color scheme, accessibility options, and trait collections, but you can add your own keys here if you want. This does not own its data. More info.
`@EnvironmentObject` reads a shared object that we placed into the environment. This does not own its data. More info.
`@FetchRequest` starts a Core Data fetch request for a particular entity. This owns its data. More info.
`@FocusedBinding` is designed to watch for values in the key window, such as a text field that is currently selected. This does not own its data.
`@FocusedValue` is a simpler version of @FocusedBinding that doesn’t unwrap the bound value for you. This does not own its data.
`@GestureState` stores values associated with a gesture that is currently in progress, such as how far you have swiped, except it will be reset to its default value when the gesture stops. This owns its data. More info.
`@Namespace` creates an animation namespace to allow matched geometry effects, which can be shared by other views. This owns its data.
`@NSApplicationDelegateAdaptor` is used to create and register a class as the app delegate for a macOS app. This owns its data.
@ObservedObject refers to an instance of an external class that conforms to the ObservableObject protocol. This does not own its data. More info.
`@Published `is attached to properties inside an ObservableObject, and tells SwiftUI that it should refresh any views that use this property when it is changed. This owns its data. More info.
`@ScaledMetric `reads the user’s Dynamic Type setting and scales numbers up or down based on an original value you provide. This owns its data. More info.
`@SceneStorage `lets us save and restore small amounts of data for state restoration. This owns its data. More info.
`@State` lets us manipulate small amounts of value type data locally to a view. This owns its data. More info.
`@StateObject` is used to store new instances of reference type data that conforms to the ObservableObject protocol. This owns its data. More info.
`@UIApplicationDelegateAdaptor` is used to create and register a class as the app delegate for an iOS app. This owns its data. 

From : https://www.hackingwithswift.com/quick-start/swiftui/all-swiftui-property-wrappers-explained-and-compared