## Clima app task:

## Topics

* dark-mode enabled app.
* vector images as image assets.
* UITextField to get user input. 
* delegate pattern.
* Swift protocols and extensions. 
* Swift guard keyword. 
* Swift computed properties.
* Swift closures and completion handlers.
* URLSession to network and make HTTP requests.
* Parse JSON with the native Encodable and Decodable protocols. 
* Learn to use Grand Central Dispatch to fetch the main thread.
* Learn to use Core Location to get the current location from the phone GPS. 

### Condition Codes
```
switch conditionID {
        case 200...232:
            return "cloud.bolt"
        case 300...321:
            return "cloud.drizzle"
        case 500...531:
            return "cloud.rain"
        case 600...622:
            return "cloud.snow"
        case 701...781:
            return "cloud.fog"
        case 800:
            return "sun.max"
        case 801...804:
            return "cloud.bolt"
        default:
            return "cloud"
        }
```
### Openweatherapp api integration and Networking:
- Networking: 
    - Create URL Object | URL(string: "the_url")?
    - Create URLSession (Emulating Browser Behavior) | ourSession = URLSession(configuration: .default)
    - Give URLSession a task (to Fetch the data) | task = ourSession.dataTask(with: URLObject, completionHandler: (_,_,_)->Void) || have to implement the function/closure
    - Start the task | task.resume()
```swift
// no closure way
// completionHandler: handlerFun(data: response: error:)
func handler(data: Data?, response: Response?, error: Error?){
    // error checking
    // implement if let to get the optional data safe way
    // then convert the data to string to debug if necessary
    let dataString = String(data: safeData, encoding: .utf8)
}
```

### Closure Example:
```swift
func calculator (n1: Int, n2: Int, operation: (Int, Int)->Int) -> Int {
    return operation(n1, n2);
}

func additions (no1: Int, no2: Int) -> Int {
    return no1 + no2
}

let result = calculator(n1: 1, n2: 2, operation: additions)
print ("Result-First: \(result)")

// closures are surround by braces {}, and closure body is separated by "in" keyword instead of braces from the parameter and return type (signature)
let result2 = calculator(n1: 1, n2: 2, operation: { (no1: Int, no2: Int) -> Int in return no1 + no2 })
print ("Result-Closure: \(result2)")

// shorter form of closure utilizing type inference
let result3 = calculator(n1: 1, n2: 2, operation: { (no1, no2) in no1 + no2 } ) 
// return type of the closure can be retrieved form signature

// further shorting by anonymous parameter name in swift, $0 becomes the 1st parameter, $1 is second and so on
let result4 = calculator(n1: 1, n2: 2, operation: { $0 + $1 } ) // "in" can also be omitted
print("result4 = \(result4)")

// if closure is the last parameter, the parameter name is optional and the closure can be placed after the ending parenthesis (like kotlin)

print("Shortest Closure Calling : \(calculator(n1: 1, n2: 2) { $0 + $1 })")
calculator(n1: 1, n2: 2) { $0 + $1 }

// practical closure implementation
let arr_list = [1,2,3,4]
arr_list.map { print($0) } // looping all the array elements and printing using minimalist code of the swift closure


// Note: Calling another method from a closure needs the self keyword explicitly
```

### Swift Higher Level Function:
* Map
* Reduce
* Filter

### JSON Decoding into Swift Struct:
=> First create a structure for the data to map. Mapping everything is not required. Map the data with struct as necessary.
=> Decodable Implementation: The struct is required to implement Decodable Protocol to be used
```swift
let decoder = JSONDecoder()
do {
  try decoder.decode(Structure.self, data)  
} catch {
    print(error)
}
```

Implementation:
```swift
func perseJson(_ data: Data) -> WeatherData {
        let jsonDecoder = JSONDecoder()
        var weatherData: WeatherData?
        
        do {
            weatherData = try jsonDecoder.decode(WeatherData.self, from: data)
        } catch {
            print(error)
        }
        
        return weatherData!
    }
```
### Task:
=> Implement the weatherapi
    - network call (see instruction above this)
    - json decoding
    - implement mvc
    - update images based on weather condition
    - update ui
    - computed property