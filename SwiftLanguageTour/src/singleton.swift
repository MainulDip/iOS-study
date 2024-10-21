class Singleton1 {
    static let shared = Singleton1()
}

class Singleton2 {
    static let shared: Singleton2 = {
        let instance = Singleton2()
        // setup code
        return instance
    }()
}


// Working Example

class Singleton3 {
    let count = 1;
    static let sharedInstance: Singleton3 = {
        let instance: Singleton3 = Singleton3();
        return instance
    }();
    
    init () {
        print("print first time only")
    }
}

let first = Singleton3.sharedInstance
let second = Singleton3.sharedInstance // calling again will not trigger the init block again.