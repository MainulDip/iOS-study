### combine:
`ObservableObject` A type alias for the Combine framework’s type for an object with a publisher that emits before the object has changed.
```swift
class ContentViewModel: ObservableObject {
    @Published var isFetching = false
    init() {
        // fetch data will be called here
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) { [weak self] in
            self?.isFetching = true 
        }
    }
}

struct ContentView: View {
    
    @ObservedObject var viewModel = ContentViewModel()
    
    var body: some View {
        NavigationView {
            ScrollView {
                if viewModel.isFetching {
                    Text("is fetching data from internet")
                }
                Text("Hello, World!")
            }
            .navigationTitle("Courses")
        }
    }
}
```

### Fetching from network:
1. build url using guard let
2. create session
3. call session with the url and get (data, urlResponse)
4. guard the urlResponse and if the reponsecode is 200
5. creace JSONDecoder() instance and guard and decode the api reponse based on model and populate this class prop which is published
6. Create an `enum NetworkError: Error {}` and throw each on different guard's else block

```swift
private func fetchData() {
        // build url using guard let
        
        // create session
        
        // call session with the url and get (data, urlResponse)
        
        // guard the urlResponse and if the reponsecode is 200
        
        // creace JSONDecoder() instance and guard and decode the api reponse based on model and populate this class prop which is published
    }
```