--------------------------- WeSplit-1 ---------------------
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


--------------------------- GuessTheFlag-2 ---------------------


### VStack, HStack and ZStack:
`VStack` for arranging things vertically.
`HStack` for arranging things horizontally
`ZStack` for arranging things by depth, draws its contents from top to bottom, back to front.
* Each Stack take same vertical space as its content.
* the size of the stack can be set using `.frame(maxWidth:maxHeight)` attaching with the stack.
* `.frame(maxWidth: .infinity, maxHeight: .infinity)` will make the stack as much space as possible.

Docs - https://developer.apple.com/tutorials/swiftui-concepts/adjusting-the-space-between-views
```swift
/**
 * A Screen With Fill with Red Color, including safe area and
 * 2 Vertical Rows  each with 2 Horizontal Columns
 * the order of modifier matters like
 * padding will not work if placed after backgorund
 */

struct ContentView: View {
    var body: some View {
        ZStack {
            Color.red.edgesIgnoringSafeArea(.all) // same as .ignoresSafeArea()
            VStack(spacing: 20) {
                HStack(spacing: 20) {
                    Text("Your content 1").padding(10).background(Color.orange)
                    Text("||")
                    Text("Your content 2").padding(10).background(Color.cyan)
                }
                .background(Color.white)
                .cornerRadius(10) // round corner
                
                HStack(spacing: 20) {
                    Text("Your content 3")
                    Text("||")
                    Text("Your content 4")
                }
                .padding(20) // the order of padding and background matters, will not work if placed after backgorund
                .background(Color.white)
                .cornerRadius(10)
            }
        }
    }
}
```
### Interesting Modifiers:
`cornerRadius` for rounded corner
`clipShape(Capsule())` for clipping with capsule shape (rounded corner effect)
`.background(.red.gradient)` prebuilt gradient on some color (to elevate the design)
`.shadow(radius: 7)` drop shadows

### Interesting Views with Modifies:
- Gradient
```swift
LinearGradient(stops: [
    .init(color: .white, location: 0.45),
    .init(color: .black, location: 0.55),
], startPoint: .top, endPoint: .bottom)

RadialGradient(colors: [.blue, .black], center: .center, startRadius: 20, endRadius: 200)

AngularGradient(colors: [.red, .yellow, .green, .blue, .purple, .red], center: .center)
```

- Button and Click Action and Images
```swift
Button("Title", role: .destructive, action: executeDelete)
.buttonStyle(.bordered)
.tint(.mint)

func executeDelete() {
    print("Now deleting…")
}
```

- Image
`Image("pencil")` will load an image called “Pencil” that you have added to your project.
`Image(decorative: "pencil")` will load the same image, but won’t read it out for users who have enabled the screen reader. This is useful for images that don’t convey additional important information.
`Image(systemName: "pencil")` will load the pencil icon that is built into iOS. This uses Apple’s SF Symbols icon collection,
```Swift
// Button can have image too
Button {
    print("Edit button was tapped")
} label: { 
    Image(systemName: "pencil")
}

// also 
Button("Edit", systemImage: "pencil") {
    print("Edit button was tapped")
}
```

- Alerts
```swift
struct ContentView: View {
    @State private var showingAlert = false

    var body: some View {
        Button("Show Alert") {
            showingAlert = true
        }
        .alert("Important message", isPresented: $showingAlert) {
            Button("OK", role: .cancel) { }
        } message: {
            Text("Please read this.")
        }
    }
}
```


--------------------------- ViewsAndModifiers-3 ---------------------

### SwiftUI View Structure and Modifiers:
Almost every time we apply a modifier to a SwiftUI view, we actually create a new view with that change applied.

- Whats under the main view? -> `UIHostingController`, it is the bridge between UIKit (Apple’s original iOS UI framework) and SwiftUI. But its not for regular purpose use. like the size of the stack can be set using `.frame(maxWidth:maxHeight)` attaching with the stack. ex, `.frame(maxWidth: .infinity, maxHeight: .infinity)` will make the stack as much space as possible.

* the order of your modifiers matters.
we can use `print(type(of: self.body))` to inspect the view and modifiers underlying ViewClass<T>. Where ViewClass<T1, T2> is not same as ViewClass<T2, T1>.
```swift
Button("Hello, world!") {
    print(type(of: self.body))
}
.frame(width: 200, height: 200)
.background(.red)

// is not same as, later case background color will not applied to the new set dimension.
Button("Hello, world!") {
    print(type(of: self.body))
}
.background(.red)
.frame(width: 200, height: 200)
```

* Same Modifier for multiple times in combination: An important side effect of using modifiers is that we can apply the same effect multiple times: each one simply adds to whatever was there before.
```swift
Text("Hello, world!")
    .padding()
    .background(.red)
    .padding()
    .background(.blue)
    .padding()
    .background(.green)
    .padding()
    .background(.yellow)
```


### some View and Opaque Type Protocol:
Opaque Type Hide implementation details about a value’s type. Likw `: some View` is any type Struct that implements View Protocol. (NB, Structs cannot inherit from another struct, can only implement multiple protocols and class can do both)
docs: https://docs.swift.org/swift-book/documentation/the-swift-programming-language/opaquetypes/


### Conditional Modifiers:
Using Modifies Conditionally to generate value using ternary operators based on a @State is more efficient than Conditionally generate different views.
```swift
@State private var useRedText = false

var body: some View {
    Button("Hello World") {
        // flip the Boolean between true and false
        useRedText.toggle()            
    }
    .foregroundStyle(useRedText ? .red : .blue)
}

/**
* ternary conditional modifiers with @State is more efficient than
* conditional view generation
*/
var body: some View {
    if useRedText {
        Button("Hello World") {
            useRedText.toggle()
        }
        .foregroundStyle(.red)
    } else {
        Button("Hello World") {
            useRedText.toggle()
        }
        .foregroundStyle(.blue)
    }
}
```
### Environment Modifiers vs Regular Modifiers:
When applied to multiple views at a time, we can override/remove environment modifiers from the child view, but not regular modifiers. Regular modifier will adds effects any way. Like `.font` is a environment modifier, but `.blur` is regular.
```swift
// the fist text will override the container applied modifier
VStack {
    Text("Gryffindor")
        .font(.largeTitle)
    Text("Hufflepuff")
    Text("Ravenclaw")
    Text("Slytherin")
}
.font(.title)

// the first text will not override the container modifier, rather adds
VStack {
    Text("Gryffindor")
        .blur(radius: 1)
    Text("Hufflepuff")
    Text("Ravenclaw")
    Text("Slytherin")
}
.blur(radius: 6)
```

* NB: there is no way of knowing ahead of time which modifiers are environment modifiers and which are regular modifiers other than reading the individual documentation for each modifier

### Properties to store and compute Views:
View can be stored to Structs propety and can be used inside layout (body: some View). 
```swift
struct ContentView: View {
    let motto1 = Text("Draco dormiens")
    let motto2 = Text("nunquam titillandus")

    var body: some View {
        VStack {
            motto1
                .foregroundStyle(.red)
            motto2
                .foregroundStyle(.blue)
        }
    }
}
```

Computed properties of View can be created as well.
```swift
var motto1: some View {
    Text("Draco dormiens")
}
```
* Swift doesn’t let us create one stored property that refers to other stored properties, because it would cause problems when the object is created. This means trying to create a TextField bound to a local property will cause problems.

But unlike the body property, Swift won’t automatically apply the @ViewBuilder attribute here, so if you want to send multiple views back you have three options.
```swift
// 1
var spells: some View {
    VStack {
        Text("Lumos")
        Text("Obliviate")
    }
}

// 2
var spells: some View {
    Group {
        Text("Lumos")
        Text("Obliviate")
    }
}

// 3
@ViewBuilder var spells: some View {
    Text("Lumos")
    Text("Obliviate")
}
```
### View Composition:
SwiftUI lets us break complex views down into smaller views without incurring much if any performance impact.
```swift
struct CapsuleText: View {
    var text: String

    var body: some View {
        Text(text)
            .font(.largeTitle)
            .padding()
            .background(.blue)
    }
}

struct ContentView: View {
    var body: some View {
        VStack(spacing: 10) {
            CapsuleText(text: "First")
                .foregroundStyle(.white)
            CapsuleText(text: "Second")
                .foregroundStyle(.yellow)
        }
    }
}
```

### Custom Modifiers:
To create a custom modifier, create a new struct that conforms to the ViewModifier protocol. This has only one requirement, which is a method called body that accepts whatever content it’s being given to work with, and must return some View. And hook it using `.modifier(YourCustomModifier)`

```swift
struct CustomModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.largeTitle)
            .foregroundStyle(.white)
            .padding()
            .background(.blue)
            .clipShape(.rect(cornerRadius: 10))
    }
}

// use the Custom Modifiers
Text("Hello World")
    .modifier(CustomModifier())
```

### Custom Modifiers With View Extension:
Extension on View (``) can be created to use the custom defined modifier in more customized way.
```swift
// Using custom modifier
struct ContentView: View {
    var body: some View {   
        Text("Hello World")
            .myCustomStyle()
    }
}

// attaching custom modifier with `extension View`
extension View {
    func myCustomStyle() -> some View {
        modifier(MyCustoModifier())
    }
}

// defining custom modifier with ViewModifier Protocol Implementation
struct MyCustoModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.largeTitle)
            .foregroundStyle(.white)
            .padding()
            .background(.blue)
            .cornerRadius(10)
    }
}
```
* custom view modifiers can have their own stored properties, whereas extensions to View cannot. So sometimes it’s better to add a custom view modifier versus just adding a new method to View

### Custom Container View (Stacks):
We can create custom Stack Container based on built-in Stacks and Views.
```swift
struct GridStack<Content: View>: View {
    let rows: Int
    let columns: Int
    // let content: (Int, Int) -> Content
    // adds more flexibility to return multiple view with @ViewBuilder wrapper, so we don't need to place the content inside another Stack to return multiple view when applying
    @ViewBuilder let content: (Int, Int) -> Content

    var body: some View {
        VStack {
            ForEach(0..<rows, id: \.self) { row in
                HStack {
                    ForEach(0..<columns, id: \.self) { column in
                        content(row, column)
                    }
                }
            }
        }
    }
}

// Use the custom Container
struct ContentView: View {
    var body: some View {
        GridStack(rows: 4, columns: 4) { row, col in
            Image(systemName: "\(row * 4 + col).circle")
            Text("R\(row) C\(col)")
        }
    }
}
```

--------------------------- Better-Rest-4 ---------------------

### Stepper & Slider View: