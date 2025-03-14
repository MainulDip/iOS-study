/*
* Generics
* Here the `Item` is used as generics type
* generics definition are marked with `<>`, Usually `<T>`
*/

func makeArray<Item>(repeating item: Item, numberOfTimes: Int) -> [Item] {
    var result: [Item] = []
    for _ in 0..<numberOfTimes {
        result.append(item)
    }
    return result
}

var array = makeArray(repeating: "knock", numberOfTimes: 4)
print(array)


// 2nd example : matching different types, Int and String here
func swapTwoValues<T>(_ a: inout T, _ b: inout T) {
    let temporaryA = a
    a = b
    b = temporaryA
}

var someInt = 3
var anotherInt = 107
swapTwoValues(&someInt, &anotherInt)
// someInt is now 107, and anotherInt is now 3


var someString = "hello"
var anotherString = "world"
swapTwoValues(&someString, &anotherString)
// someString is now "world", and anotherString is now "hello"


/*
* Function inside Generics
*/
print("\n-------------------------Function in Generics----------------------Starts-------\n")


print("\n-------------------------Custom Generics | Generics Struct/Class----------Start---\n")

// implementing a Stack data structure, that only allows pushing and popping
struct Stack<Element> {
    var items: [Element] = []
    mutating func push(_ item: Element) {
        items.append(item)
    }
    mutating func pop() -> Element {
        return items.removeLast()
    }
}

var stackOfStrings = Stack<String>()
stackOfStrings.push("uno")
stackOfStrings.push("dos")
stackOfStrings.push("tres")

// Generic Where Clause | associated type