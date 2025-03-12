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

/*
* Function inside Generics
*/
print("\n-------------------------Function in Generics----------------------Starts-------\n")