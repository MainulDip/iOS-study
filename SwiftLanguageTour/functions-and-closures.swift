// Basic Fn
func greet(_ person: String, on day: String) -> String {
    return "Hello \(person), today is \(day)."
}
greet("John", on: "Wednesday")

// Fn returning Tuple and accepting array as arguments
func calculateStatistics(scores: [Int]) -> (min: Int, max: Int, sum: Int) {
    var min = scores[0]
    var max = scores[0]
    var sum = 0

    for score in scores {
        if score > max {
            max = score
        } else if score < min {
            min = score
        }
        sum += score
    }

    return (min, max, sum)
}
let statistics = calculateStatistics(scores: [5, 3, 100, 3, 9])
print(statistics.sum) // Prints "120"
print(statistics.2) // Prints "120"


// Nested Fn

func returnFifteen() -> Int {
    var y = 10
    func add() {
        y += 5
    }
    add()
    return y
}
print("returnFifteen() : \(returnFifteen())")

// Fn returning another fn | first-class type:
func makeIncrementer() -> ((Int) -> Int) {
    func addOne(number: Int) -> Int {
        return 1 + number
    }
    return addOne
}
var increment = makeIncrementer()
print("increment(7): \(increment(7))")


// Closure | Fn taking another Fn as arguments

func hasAnyMatches(list: [Int], condition: (Int) -> Bool) -> Bool {
    for item in list {
        if condition(item) {
            return true
        }
    }
    return false
}
func lessThanTen(number: Int) -> Bool {
    return number < 10
}
var numbers = [20, 19, 7, 12]
print("hasAnyMatches(list: numbers, condition: lessThanTen): \(hasAnyMatches(list: numbers, condition: lessThanTen))")


// Clouser using {} 1st example
var bracesClosure = hasAnyMatches(list: numbers, condition: { (number: Int) -> Bool in
    return number < 10
})

print("bracesClosure : \(bracesClosure)")

// Clouser using {} braces/anonymous and "named function" both style
func countTotal(list: [Int], math: (Int, Int) -> Int) -> Int {
    var total = 0;
    for item in list {
        total = math(total, item)
    }
    return total
}
let numberList = [21, 19, 7, 12]

// closure {} braces/anonymous style | "in" is used to separate the arguments and return type from body
var totalMath = countTotal(list: numberList, math: { (old: Int, new: Int) -> Int in
    return old + new
})
print("totalMath: \(totalMath)")

// closure "named function" style | define the closure
func calculation (old: Int, new: Int) -> Int {
    return old + new
}
var getTheTotal = countTotal(list: numberList, math: calculation)
print("Getting total from named closure: \(getTheTotal)")

