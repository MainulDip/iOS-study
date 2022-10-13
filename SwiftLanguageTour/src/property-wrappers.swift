/*
* Property Wrappers
* There are some including required maybe, run from xcode to test
*/


@propertyWrapper
struct TwelveOrLess {
    private var number = 0
    var wrappedValue: Int {
        get { return number }
        set { number = min(newValue, 12) }
    }
}

struct SmallRectangle {
    @TwelveOrLess var height: Int
    @TwelveOrLess var width: Int
}


var rectangle = SmallRectangle()
print(rectangle.height)
// Prints "0"

rectangle.height = 10
print(rectangle.height)
// Prints "10"

rectangle.height = 24
print(rectangle.height)
// Prints "12"

// // Using non-attribute style
// struct SmallRectangle2 {
//     private var _height = TwelveOrLess()
//     private var _width = TwelveOrLess()
//     var height: Int {
//         get { return _height.wrappedValue }
//         set { _height.wrappedValue = newValue }
//     }
//     var width: Int {
//         get { return _width.wrappedValue }
//         set { _width.wrappedValue = newValue }
//     }
// }


// var rectangle2 = SmallRectangle2()
// print(rectangle2.height)
// // Prints "0"

// rectangle2.height = 10
// print(rectangle2.height)
// // Prints "10"

// rectangle2.height = 24
// print(rectangle2.height)
// // Prints "12"
