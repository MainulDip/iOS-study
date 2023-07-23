/*
* signature
* extension Type/Struct/Protocol { methodName() {... body ...} }
* extension Protocol {...} can be used to provide protocol's default implementation later. As protocol method cannot have bodies but just signature
So extension is a good way to provide default implementation. 
Most of the Official Delegate Protocol Provide Default implementation through extension, so we don't need to implement all those protocol methods.
*/

// adding Double's decimal precision point by creating built in round function a param
import Foundation

extension Double {
    func round(_ places: Int) -> Double {
        let precisionNum = pow(10, Double(places))
        var n = self // value of the applied double
        n = n * precisionNum
        n.round() // will make it a whole number
        n = n / precisionNum // will add the decimal places again
        return n
    }
}
var myDouble = 3.1416

print(myDouble.round(3)) // outputs 3.141