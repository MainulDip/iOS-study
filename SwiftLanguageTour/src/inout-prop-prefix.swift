/*
* `inout` are used after function's parameter (just before Type definition) to mark it as modifiable
* without `inout` the function parameter/s are constant/non-changeable
* only `variable` can be passed to the `inout` parameter with `&` prefix
* using `let` constant reference inside of the `inout` parameter will not work
*/


func complexCompute( a: inout Float, b: inout Float, c: Float) {
    a = a * a + c * 3.1416
    b = b * b - c * 3.1416
}

var x: Float = 12 // when inserted into as param, needs to be prefixed with `&`
var y: Float = 34
let z: Float = 23

let computeResult: Void = complexCompute(a: &x, b: &y, c: z)
print("x = \(x), y = \(y) and unchanged z = \(z)")