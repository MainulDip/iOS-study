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

### JSON Decoding into Swift Structs
=> First create a structure for the data to map. Mapping everything is not required. Map the data with struct as necessary.
=> Decodable Implementation: The struct is required to implement Decodable Protocol to be used. Also other structs within the struct also need to be Decodable protocol
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
### Type-alias | Combining Protocol Into 1 :
It combines multiple protocol into/under single name. Like Decodable and Encodable Protocols can be used using Codeable type-alias for both combined.

### Delegation Workflow:
=> Create a protocol with function to implement
=> Create/set a delegate property as optional type of the protocol on the sender class
=> Implement the protocol on the class that need ot expose it's method to receive/update data and set "self" of that class as the sender class delegate property
=> class the self.delegate.methodName form the sender class/struct to call the receiver class's method (method that is on the protocol)
### Struct with Empty Property vs Filled Property:
If a struct's property value is not assigned (or non optional) when declared, it is necessary to provide those values when it needs be to instantiated. 
If the property value is assigned (or optional) when declared/create, instantiation/initialization does not required to provide values.
### Threads and DispatchQueue :
Any background (non main thread) tasks (like network request or long running computation) need the help of DispatchQueue to update the main thread.
```swift
DispatchQueue.main.async {
    self.cityLabel.text = weatherModel.cityName
}
```
### Swift Extension:
```swift
/*
* signature
* extension Type/Struct/Protocol { methodName() {... body ...} }
* extension Protocol {...} can be used to provide protocol's default implementation later. As protocol method cannot have bodies but just signature
So extension is a good way to provide default implementation. 
Most of the Official Delegate Protocol Provide Default implementation through extension, so we don't need to implement all those protocol methods.
*/

// adding Double's decimal precision point by creating built in round function a param
import Foundation

extension Double {
    func round(_ places: Int) -> Double {
        let precisionNum = pow(10, Double(places))
        var n = self // value of the applied double
        n = n * precisionNum
        n.round() // will make it a whole number
        n = n / precisionNum // will add the decimal places again
        return n
    }
}
var myDouble = 3.1416

print(myDouble.round(3)) // outputs 3.141
```
### Core Location :
Start By adding "Privacy - Location When ..." prop with value (that will be shown to the user) inside info.plist
```swift
import CoreLocation
// class prop
let locationManager = CLLocationManager()
// on viewDidLoad request for user permission
locationManager.requestWhenInUseAuthorization()
// if granted, then request for actual location
locationManager.requestLocation() // will return location onetime 
```
### Task
=> Implement the weatherapi
    - network call (see instruction above this)
    - json decoding
    - implement mvc
    - update data from weatherManager to controller using delegate pattern
    - update images based on weather condition
    - update ui
    - computed property
    - Debug the double request for London
### Ongoing:
- 14.47