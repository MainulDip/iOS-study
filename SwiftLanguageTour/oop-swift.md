## Swift Object Oriented Programmings
Topic maps including below

### Struct (Data) vs Class:
structs/structures are to represent common kinds of data. Structs are value based, not reference based like classes. local changes to a structure aren’t visible to the rest of your app unless you intentionally communicate those changes as part of the flow of your app. The Swift standard library and Foundation use structures for types you use frequently, such as numbers, strings, arrays, and dictionaries.


when two different class instances have the same value for each of their stored properties, they’re still considered to be different by the identity operator (===). It also means that when you share a class instance across your app, changes you make to that instance are visible to every part of your code that holds a reference to that instance.

* Use structures by default.

* Use classes when you need Objective-C interoperability.

* Use classes when you need to control the identity of the data you’re modeling.

* Use structures along with protocols to adopt behavior by sharing implementations.

```swift
struct PenPalRecord {
    let myID: Int
    var myNickname: String
    var recommendedPenPalID: Int
}

var myRecord = try JSONDecoder().decode(PenPalRecord.self, from: jsonResponse)
```
