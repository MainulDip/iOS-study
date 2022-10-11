/*
* Stored Properties
* unless lazy, every property should have value when initialized
*/

struct FixedLengthRange {
    var firstValue: Int
    let length: Int = 7 // for const, it's only setable once
    private var sth: Int
    init(_ a: Int){
        firstValue = a
        sth = a + length
    }
}
var rangeOfThreeItems = FixedLengthRange(7)
print("\(rangeOfThreeItems.firstValue) \(rangeOfThreeItems.length)")