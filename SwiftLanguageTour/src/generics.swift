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


print("\n-------------------------Custom | Generics with Struct/Class----------Start---\n")

// implementing a Stack data structure, that only allows pushing and popping
struct StackEx<Element> {
    var items: [Element] = []
    mutating func push(_ item: Element) {
        items.append(item)
    }
    mutating func pop() -> Element {
        return items.removeLast()
    }
}

var stackOfStrings = StackEx<String>()
stackOfStrings.push("uno")
stackOfStrings.push("dos")
stackOfStrings.push("tres")

// Protocol with Generic | associated type & it's constraints | Where Clause
// the `Item` is the generic type here
protocol Container {
    associatedtype Item: Equatable
    mutating func append(_ item: Item)
    var count: Int {get}
    subscript(i: Int) -> Item {get}
}

struct Stack<Element: Equatable>: Container {
// can also be written
// struct Stack<Element>: Container where Element: Equatable {

    // original Stack<Element> implementation
    var items: [Element] = []
    mutating func push(_ item: Element) {
        items.append(item)
    }
    mutating func pop() -> Element {
        return items.removeLast()
    }
    // conformance to the Container protocol
    mutating func append(_ item: Element) {
        self.push(item)
    }
    var count: Int {
        return items.count
    }
    subscript(i: Int) -> Element {
        return items[i]
    }
}

var stack1 = Stack<Int>()
stack1.append(10)
stack1.append(20)

print("stack1.count = \(stack1.count)")


protocol SuffixableContainer: Container {
    associatedtype Suffix: SuffixableContainer where Suffix.Item == Item
    func suffix(_ size: Int) -> Suffix
}

extension Stack: SuffixableContainer {
    /// typealias is optional, as it will be inferred from the function
    typealias Suffix = Stack
    /// show number of last element/s specified in size stored
    func suffix(_ size: Int) -> Stack {
        var result = Stack()
        for index in (count - size)..<count {
            result.append(self[index])
        }
        return result
    }
}

let suffix = stack1.suffix(2)
for (i, item) in suffix.items.enumerated() {
    print("suffix item \(i) = \(item)")
}


print("\n\n---------Extension with generic where constraint clause-------\n\n")
// Extension with a generic where clause
extension Container where Item: Equatable {
    func startsWith(_ item: Item) -> Bool {
        return count >= 1 && self[0] == item
    }
}

// Contextual where clause (conditional type matching in function/s), without this, it will be required to write multiple extensions each with different type matching with where clause
extension Container {
    func average() -> Double where Item == Int {
        var sum = 0.0
        for index in 0..<count {
            sum += Double(self[index])
        }
        return sum / Double(count)
    }
    func endsWith(_ item: Item) -> Bool where Item: Equatable {
        return count >= 1 && self[count-1] == item
    }
}

stack1.append(37)
print(stack1.average())
// Prints "22.333333333333332"
print(stack1.endsWith(37))
// Prints "true"





// Generic Subscript