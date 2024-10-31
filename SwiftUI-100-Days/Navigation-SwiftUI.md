### NavigationLink as Button:
note https://stackoverflow.com/questions/57130866/how-to-show-navigationlink-as-a-button-in-swiftui....
```swift
NavigationLink(destination: WorkoutDetail(workout: workout)) {
  WorkoutRow(workout: workout)
}
.buttonStyle(ButtonStyle3D(background: Color.yellow))

Button(action: {
    print("Floating Button Click")
}, label: {
    NavigationLink(destination: AddItemView()) {
         Text("Open View")
     }
})
```

### NavigationLink Property Binding:
Its not required to wrap the view inside the NavigationLink to make it trigger the navigation when pressed.

We can bind a property with our NavigationLink and whenever we change that property our navigation will trigger irrespective of what action is performed. For example:

```swift
struct SwiftUI: View {

@State private var action: Int? = 0

var body: some View {
    
    NavigationView {
        VStack {
            NavigationLink(destination: Text("Destination_1"), tag: 1, selection: $action) {
                EmptyView()
            }
            NavigationLink(destination: Text("Destination_2"), tag: 2, selection: $action) {
                EmptyView()
            }
            
            Text("Your Custom View 1")
                .onTapGesture {
                    //perform some tasks if needed before opening Destination view
                    self.action = 1
                }
            Text("Your Custom View 2")
                .onTapGesture {
                    //perform some tasks if needed before opening Destination view
                    self.action = 2
                }
        }
    }
}
```