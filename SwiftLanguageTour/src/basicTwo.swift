// Optionals in depth
let cNum = "1234"
let cStr = "Something"
let convertNumToInt = Int(cNum) // implicit type is "Int?"
let convertStrToInt = Int(cStr)

// Int(value) will return the number if conversion is successful, or nil if faild. Hence the type "Int?"

let convertNumToIntFoptional: Int? = Int(cNum) // explicit type is redundaunt here, because Int(v) will implicitly cast to "Int?"
let convertNumToIntUnwrapped = Int(cNum)! // but throw error if forced unwrapped is applied to "nil" or conversion is not successful 

print(convertNumToInt) // Optional(1234)
print(convertStrToInt) // nil
// print(convertNumToInt as Any) // to silence warning

print(convertNumToIntFoptional) // Optional(1234)
print(convertNumToIntFoptional!) // 1234
print(convertNumToIntUnwrapped) // 1234


/**
 * If Statements and Forced Unwrapping
*/
print("\nIf Statements and Forced Unwrapping:\n")

// Only apply Forced Unwrapping "value!" when you're sure, as it will throw error on "nil"
if convertNumToInt != nil {
    print("convertNumToInt contains some integer value of \(convertNumToInt!).")
}

/**
 * Optional Binding
 * this can be used to find out whether an optional contains a value, and if so, to make that value available as a temporary constant or variable.
*/
print("\nOptional Binding:\n")

if let convertedInt = Int(cNum) {
    print ("The string \"\(cNum)\" is covertable to Integer : \(convertedInt) ")
} else {
    print("\"\(cNum)\" is not covertable to Integer value")
}