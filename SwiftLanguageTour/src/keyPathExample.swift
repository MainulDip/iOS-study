struct SomeStructure {
    var someValue: Int
}

var s = SomeStructure(someValue: 12)
let pathToProperty = \SomeStructure.someValue
let pathToPropertyWritable: WritableKeyPath<SomeStructure, Int> = \SomeStructure.someValue
let pathToPropertyReadOnly: KeyPath<SomeStructure, Int> = \SomeStructure.someValue

let value = s[keyPath: pathToProperty]
print(pathToProperty) // will print `\SomeStructure.someValue`
print(value) // will print `12`

print("---------------------------ReadOnlyKeyPath | KeyPath----------------------------\n")

print(s[keyPath: pathToPropertyReadOnly]) // print `12`
// s[keyPath: pathToPropertyReadOnly] = 4321 // error `... is a read-only key path`
// print(s[keyPath: pathToPropertyReadOnly])


print("\n----------------------------WritableKeyPath | Default---------------------------------\n")

s[keyPath: pathToPropertyWritable] = 1234
print(s[keyPath: pathToPropertyWritable]) // print `1234`

