### Ongoing:
https://www.hackingwithswift.com/books/ios-swiftui/adding-a-segmented-control-for-tip-percentages.......
### Next (Ask Blake):



### Now:

- `@StateObject` and vs `@ObservedObject`
    - both `property-wrappers` tell a SwiftUI view to update in response to changes from an observed object (@Observable & ObservableObject Protocol). When a view redraws, `@StateObject` retain its old state but `@ObservedState` doesn't (starts from initial state). When injecting state object from a parent view, `@ObservedState` can suite there

- `@Binding` is to use state in a child view (expecting state will be injected from its parent), the `@state` cannot be left uninitialized, binding is saviour here

- `@EnvironmentObject`
- `@Environment`
- `ObservableObject` protocol vs @Observable
- Preference Key
- 


### Must Check:
Recursion Technic https://www.geeksforgeeks.org/recursive-functions/
Different ways to implement recursion 


### Charts:
For android and ios : https://github.com/PhilJay android `MPAndroidChart` | iOS `ChartsOrg/Charts`
For iOS only : Swift Charts https://developer.apple.com/documentation/charts.......
For React Native : Gifted Chart
For React : 
For Web : Plot.js, D3.js Shadcn-charts
