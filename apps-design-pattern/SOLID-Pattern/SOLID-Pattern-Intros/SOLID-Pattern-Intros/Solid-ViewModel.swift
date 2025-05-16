//
//  Solid-ViewModel.swift
//  SOLID-Pattern-Intros
//
//  Created by Mainul Dip on 5/15/25.
//

import Foundation

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
