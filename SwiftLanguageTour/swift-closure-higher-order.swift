let digitNames = [
    0: "Zero", 1: "One", 2: "Two",   3: "Three", 4: "Four",
    5: "Five", 6: "Six", 7: "Seven", 8: "Eight", 9: "Nine"
]
let numbers = [16, 58, 510]

let strings = numbers.map { number -> String in
    var number = number
    var output = ""
    repeat {
        print("digitNames[number % 10]! : \(digitNames[number % 10]!)")
        print("digitNames[number % 10] : \(digitNames[number % 10])")
        output = digitNames[number % 10]! + output
        print("number: \(number)")
        number /= 10 // as number is Int (not double), 0.99 will be 0 here
        print("number: \(number)")
    } while number > 0
    print(output)
    return output
}
print(strings)
print(9/10) // 0 , because of Int, not Double