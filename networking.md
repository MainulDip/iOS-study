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

### URLSession In Depth (Always requires HTTPS as ATS/App-Transport-Protocol from ios 9.0 and macOS 10.11):
URLSession the goto API for networking/caching, ie, Fetch/Download/Upload (+ WebSocket Communication) data to/from the server. Can perform background downloads when the app isn't running. 

- Essentials `URLSession` & `URLSessionTask`
    - `URLSession` has different kind
        - `URLSession.shared` for basic request (no config, no delegation)
        - Default (Custom) `URLSession` instance for custom config and delegation
        - Ephemeral sessions don't write caches, cookies or credentials to disk
        - Background sessions for uploading/downloading (ie, app isn't running)
    
    - `URLSessionTask` is 4 kinds, is used within a session, upload/retrieve data as a file on disk or as NSData object/s in memory
        - Data Task to send/retrieve NSData object/s, short and interactive request to a server
        - Upload Task for uploading file/s, also in background
        - Download Task for downloading file/s
        - WebSocket Task for exchanging messages over TCP/TLS

- Request and Response : `URLRequest`, `URLResponse` & `HTTPURLResponse`

URLSession API Breakdown
- Uploading
- Downloading
- Cache Behavior
- Authentication and credentials
- Networking activity attribution
- Cookies
- Errors

### URLSession with Delegate:
Tasks in a session can share a common delegate object to provide and obtain information when various event occur, ie, `Authentication Fail`, `Data arrives from server` and `Data become available` etc.

Delegation can also be `nil` if capturing event is not used.

Memory Leak: The session object keeps a strong reference to the delegate until the app exits or explicitly invalidates the session. So not invalidating the session will create memory leak until the app is terminated.

`URLSessionTaskDelegate` method and `delegate` prop


### Asynchronous URLSession:
Like most networking APIs, the URLSession API is highly asynchronous. Depending on the method call, it returns data three ways

1. `async` marked func, ie, `data(from:delegate:)`, `download(from:delegate:)` suspends on `await` call. `bytes(from:delegate:)` method to receive data as an `AsyncSequence`, which uses `for-await-in` syntax to iterate over. The URL type also offers covenience methods to fetch bytes or lines from the shared URL session.

2. usually provide completion handler

3. receive callbacks to a delegate method as the transfer progresses and immediately after it completes

the URLSession also provides status and progress properties to make programmatic decisions based on the current state of the task (with the caveat that its state can change at any time).

### Thread safety:

The URL session API is thread-safe. You can freely create sessions and tasks in any thread context. When your delegate methods call the provided completion handlers, the work is automatically scheduled on the correct delegate queue.

### URLRequest In Depth:

### URLRequest with Session:
URLRequest only represents information about the request. Use URLSession classes (), to send the request to a server

### User's internet/online status/strength detection and API call:


### Legacy API (Needs to migrated into URLSession API):
All classes and protocols starting with `NSURL...` are legacy API and should be replaced with `URLSession`.

- Legacy URL Connection `NSURLConnection`, `NSURLConnectionDelegate`, `NSURLConnectionDataDelegate`, `NSURLConnectionDownloadDelegate`

- Legacy URL Download `NSURLDownload`, `NSURLDownloadDelegate`

- Legacy URL Handle `NSURLHandle`

`URLAuthenticationChallengeSender` is only for the legacy `NSURLConnection` and `NSURLDownload` classes. For URLSession-based code, `URLSession.AuthChallengeDisposition` constants is used to the provided completion handler blocks.

### Networking Reading List:
1. https://developer.apple.com/documentation/foundation/url_loading_system ( contains guide on everything Networking + caching + lots of thing)

2. https://developer.apple.com/documentation/foundation/urlsession