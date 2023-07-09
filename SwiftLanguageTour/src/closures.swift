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