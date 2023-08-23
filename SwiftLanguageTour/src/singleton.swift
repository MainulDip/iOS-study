class Car {
    var color = "Red"

    static let singletonCar = Car()
}

let myCar = Car.singletonCar
myCar.color = "Blue"

let yourCar = Car.singletonCar
print("Your Car Color: ", yourCar.color) // prints : Your Car Color:  Blue

class A {
    init() {
        Car.singletonCar.color = "Brown"
    }
}

class B {
    init() {
        print("From Class B: ", Car.singletonCar.color)
    }
}

let a = A() // sets color to Brown
let b = B() // prints : From Class B:  Brown