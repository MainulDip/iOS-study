import Foundation

@propertyWrapper
struct Email {
  var wrappedValue: String
  var projectedValue: Bool {
    get {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailPred = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailPred.evaluate(with: wrappedValue)
     }
    set {
        print("Setting something")
    }
  }
}

struct Person {
    let name: String
    @Email var email: String
}


var p = Person(name: "ProjectedValue1", email: "gmail.com")
print(p.name)
print(p.email)
print(p.$email) // false, as gmail.com is not a valid email address
p.$email = true // as the projectedValue supplies a set along with get
// but it will not change the output as the setter is only printing in the console
p.email = "g@gmail.com"
print(p.$email) // true, changed g@gmail.com is a valid email address