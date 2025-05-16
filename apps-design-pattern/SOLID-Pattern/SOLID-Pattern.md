### SOLID Pattern:

Single Responsibility
Open (to adopt change) Close (to modification)
Liskov substitution principal 
    - (Subtypes must be substitutable for the base type, ie `enum NetworkError: Error{}` )
Interface Segregation 
    - (client should not be forced to implement a interface that may not be used)
Dependency Inversion 
    - (Higher level module should not depend directly for lower level module)
    - both higher and lower module should depend on 3rd module

### Single Responsibility Principle:
A class should implement one function responsible for business logic. 

We can have a builder class which can glue all the pieces together for easy access. But one class should be responsible for single business logic declaration.

```swift
class SolidVM {
    init () {
        print("SolidVM initialized")
        let products: [Product] = [
            .init(price: 99.99),
            .init(price: 9.99),
            .init(price: 29.99)
        ]
        
        let invoiceNonSolid = InvoiceNonSolid(products: products, discountPercentage: 20)
        invoiceNonSolid.printInvoice()
        
        let invoiceSolidSRP = InvoiceSolidSRP(products: products, discountPercentage: 20)
        invoiceSolidSRP.printInvoice()
        invoiceSolidSRP.saveInvoice()
    }
}

// MARK: S - Single Responsibility Principal
/*
 A class should only be responsible for one thing
    - write protocol first, difining a single responsibility and then implement that to a single class
    - later build a builder class to include all those SRP Class funciton to the builder's class's function
 */

struct Product {
    let price: Double
}

struct InvoiceNonSolid {
    var products: [Product]
    let id = NSUUID().uuidString
    var discountPercentage: Double
    
    var total: Double {
        let total = products.map({$0.price}).reduce(0, {$0 + $1})
        let discountedAmount = total * (discountPercentage / 100)
        return total - discountedAmount
    }
    
    func printInvoice() {
        print("-------------------")
        print("Invoice ID: \(id)")
        print("Total: \(total)")
        print("Discounts: \(discountPercentage)")
        print("-------------------")
    }
    
    func saveInvoice() {
        // save invoice data locally or to database
    }
}


// SRP - Single Responsibility Principle
struct InvoiceSolidSRP {
    var products: [Product]
    let id = NSUUID().uuidString
    var discountPercentage: Double
    
    var total: Double {
        let total = products.map({$0.price}).reduce(0, {$0 + $1})
        let discountedAmount = total * (discountPercentage / 100)
        return total - discountedAmount
    }
    
    func printInvoice() {
        let printer = InvoicePrinter(invoice: self)
        printer.printInvoice()
    }
    
    func saveInvoice() {
        let invoicePersistance = InvoicePersistance(invoice: self)
        invoicePersistance.saveInvoice()
    }
}

struct InvoicePrinter {
    let invoice: InvoiceSolidSRP
    
    func printInvoice() {
        print("-------------------")
        print("Invoice ID: \(invoice.id)")
        print("Total: \(invoice.total)")
        print("Discounts: \(invoice.discountPercentage)")
        print("-------------------")
    }
}

struct InvoicePersistance {
    let invoice: InvoiceSolidSRP
    
    func saveInvoice() {
        // save invoice data locally or to database
        print("Invoice is saved successfully!")
    }
}
```


### Open Close Principle:
Software entities (classes, modules, functions, etc) should be open for extension and close for modification. 

In other words, we can add additional functionality (extension) without touching the existing code (modification) of an object.

```swift
// its violating OCP and SRP
// doing multiple responsibility and
// we're adding code to it, which should be restricted and only adding functionality through extension is allowed
struct InvocePersistanceNoNOCP {
    let invoice: InvoiceSolidSRP
    
    func saveInvoceToCoreData() {
        print("Saving invoice to CoreData")
    }
    
    func saveInvoiceToDatabase() {
        print("Saving invoice to Database")
    }
}

struct InvocePersistanceOCP {
    let persistence: InvoicePersistable
    
    func saveInvoice(invoice: InvoiceSolidSRP) {
        persistence.save(to: invoice)
    }
}

protocol InvoicePersistable {
    func save(to invoice: InvoiceSolidSRP)
}

struct DatabasePersistanceOCP: InvoicePersistable {
    func save(to invoice: InvoiceSolidSRP) {
        print("Saving invoice to Database")
    }
}

struct CoreDataPersistanceOCP: InvoicePersistable {
    func save(to invoice: InvoiceSolidSRP) {
        print("Saving invoice to CoreData")
    }
}

let invoiceSolidSRP = InvoiceSolidSRP(products: products, discountPercentage: 20)
        
// open close princicle
let databasePersistance = DatabasePersistanceOCP()
let coreDataPersistance = CoreDataPersistanceOCP()
let persistanceDBOCP = InvocePersistanceOCP(persistence: databasePersistance)
let persistenceCoreDataOCP = InvocePersistanceOCP(persistence: coreDataPersistance)
persistanceDBOCP.saveInvoice(invoice: invoiceSolidSRP)
persistenceCoreDataOCP.saveInvoice(invoice: invoiceSolidSRP)
```


### Liskov Substitution Principle:
 Derived or child classes/structures must be substitutable for their base/parent class

```swift
enum APIError: Error {
    case invalidURL
    case invalidResponse
    case invalidDecoding
}
// usages: We can throw any error that conforms (child classes) to the Error protocol which is a base class here
```


### Interface Segregation Principle:
 client should not be forced to implement a interface that may not be used
```swift
// this is not good, everything should be divided into multiple protocol each with its own business logic
protocol GestureProtocol {
    func didTap()
    func didDoubleTap()
    func didLongPress()
}

class SuperButton: GestureProtocol {
    func didTap() {
        print("SingleTap Implementaiton")
    }
    
    func didDoubleTap() {
        print("DoubleTap Implementaiton")
    }
    
    func didLongPress() {
        print("LongTap Implementaiton")
    }
}

// this violates the `interface segregation principle`
// as the singleTapppingButton also forced to implememnt other types of gesture al well
class SingleTappingButton: GestureProtocol {
    func didTap() {
        print("SingleTap Implementaiton")
    }
    func didDoubleTap() {}
    func didLongPress() {}
}

// interface segregated way
protocol SingleTappable {
    func didTap()
}

protocol DoubleTapable {
    func didDoubleTap()
}

protocol LongPressable {
    func didLongPress()
}

class BetterSupperButton: SingleTappable, DoubleTapable, LongPressable {
    func didTap() {
        print("SingleTap Implementation")
    }
    
    func didDoubleTap() {
        print("DoubleTap Implementation")
    }
    
    func didLongPress() {
        print("LongTapp Implementation")
    }
}

class BetterSingleTapButton: SingleTappable {
    func didTap() {
        print("SingleTap Implementation")
    }
}
```

### Dependency Inversion Principle:
 - High level module should not depend on low level modules, but should depend on abstraction
 - If a high level module imports any low-level module, the code becomes tightly coupled
 - Changes in one class could break another
 - code should be loosely coupled
 - usages: Low level module should conform to a protocol and High level will that protocol as it's dependency
```swift
// ------------- Wrong Way Of Doing ----------------------
struct DebitCardPayment {
    func execute(amount: Double) {
        print("DebitCard Payment Success for card \(amount)")
    }
}

struct StripePayment {
    func execute(amount: Double) {
        print("DebitCard Payment Success for card \(amount)")
    }
}

struct ApplePayPayment {
    func execute(amount: Double) {
        print("DebitCard Payment Success for card \(amount)")
    }
}

struct Payment {
    var debitCardPayment: DebitCardPayment?
    var stripePayment: StripePayment?
    var applePayPayment: ApplePayPayment?
}

class ExecutePayment {
    init() {
        let debitCardPayment = DebitCardPayment()
        let payment = Payment(debitCardPayment: debitCardPayment, stripePayment: nil, applePayPayment: nil)
        payment.debitCardPayment?.execute(amount: 100)
        // making direct dependency of lower level module and Optional possibility will not predict in advanced about the exact payment method
        // so in another place of the app, we can write payment with stripe, which is not even supplied
        payment.stripePayment?.execute(amount: 100)
    }
}


// ----------------------- Good way | Dependency Inversion -------
// Better way of doing with dependency inversion principle

// creating abstraction
protocol PaymentMethod {
    func execute(amount: Double)
}

// lower level module, implementing the abstraction
struct DebitCardPaymentDI: PaymentMethod {
    func execute(amount: Double) {
        print("DebitCard Payment Success for card \(amount)")
    }
}

// lower level module, implementing the abstraction
struct StripePaymentDI: PaymentMethod {
    func execute(amount: Double) {
        print("DebitCard Payment Success for card \(amount)")
    }
}

// lower level module, implementing the abstraction
struct ApplePayPaymentDI: PaymentMethod {
    func execute(amount: Double) {
        print("DebitCard Payment Success for card \(amount)")
    }
}

// Higher Level Module, making the abstraction as its dependency (paymentMethod), not lower level module directly
struct PaymentDI {
    let paymentMethod: PaymentMethod
    
    func makePayment(bill: Double) {
        paymentMethod.execute(amount: bill)
        // calling abstraction method without dealing with the complexity of deciding the exact payment method
    }
}

class ExecutePaymentUsingDI {
    init() {
        let debitCardPaymentDI = DebitCardPaymentDI()
        let paymentDI = PaymentDI(paymentMethod: debitCardPaymentDI)
        paymentDI.makePayment(bill: 77)
        // this is a much cleaner approach
        // paymentDI.makePayment could be called from another part of the app
        // the higher level module and caller code doesn't have to make decision or assume what payment method should are being used
    }
}
```