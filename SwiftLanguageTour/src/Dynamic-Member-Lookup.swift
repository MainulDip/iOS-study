import Foundation

@dynamicMemberLookup
struct Person {
    subscript(dynamicMember member: String) -> String {
        let properties = ["name": "Hello", "city": "World"]
        return properties[member, default: ""]
    }
}

let p1 = Person()
// even though, `name`, `city` doesn't exists as Person's member property
// this can be accessed 
print(p1.name) // Hello
print(p1.city) // World
print(p1.favoriteIceCream) // returns empty string


@dynamicMemberLookup
struct Person2 {
    subscript(dynamicMember member: String) -> String {
        let properties = ["name": "Hello", "city": "World"]
        return properties[member, default: ""]
    }

    subscript(dynamicMember member: String) -> Int {
        let properties = ["age": 26, "height": 178]
        return properties[member, default: 0]
    }
}

let p2 = Person2()
let name: String = p2.name
let age: Int = p2.age
print("name = \(name) age = \(age)")
print("Casting name: \(p2.name as String) and age: \(p2.age as Int)")