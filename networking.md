## Overview:
Jump starting guide on Networking

### Process
- 1st: Build the url form String
- 2nd: Create a Session Instance
- 3rd : build task as dataTask on the session instance with the url and implement data and error handling. This part we also need to parse json data. To perse JSON data, we need to create data structure (`mapping swift object from json`) with same prop name as json data
- 4th: finally start the task with task.resume
```swift
class NetworkManager: ObservableObject {

    @Published var res = [Post]()

    func fetchUrl() {
        // 1st build the URL form string
        if let theUrl = URL(string: "http://hn.algolia.com/api/v1/search?tags=front_page") {

            // Create a session Instance
            let session = URLSession(configuration: .default)
            
            // build the task implementing data process and error handling
            let task = session.dataTask(with: theUrl) { data, _, err in
               
                if let error = err {
                    print(error)
                    return
                }
                
                if let d = data {
                    
                    // perse json
                    let decoder = JSONDecoder()
                    do {
                        let parsedData = try decoder.decode(Results.self, from: d)
                        DispatchQueue.main.async {
                            self.res = parsedData.hits
                        }
                    } catch {
                        print("Catch Block Error: ", error)
                    }
                }
            }
            
            // Start the task
            task.resume()
        }
    }
}


struct Results: Decodable {
    var hits: [Post]
}

struct Post: Decodable, Identifiable {
    var id: String {
        return objectID
    }
    let objectID: String
    let points: Int
    let title: String
    let url: String?
}
```