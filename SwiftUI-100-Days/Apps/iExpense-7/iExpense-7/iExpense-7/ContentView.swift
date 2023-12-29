//
//  ContentView.swift
//  iExpense-7
//
//  Created by Mainul Dip on 12/18/23.
//

import SwiftUI

struct ContentView: View {
    /** Reading form UserDefaults
     * if the key can’t be found on first run
     *  it just sends back 0
     */
    @State private var expenses = Expenses()
    var sth = "Something"
    
    var body: some View {
        NavigationStack {
            List {
                ForEach(expenses.items, id: \ExpenseItem.name) { item in
                    Text(item.name)
                    Text("\(item[keyPath: \ExpenseItem.name])")
                    Button("Sth") {
                        print(\ExpenseItem.name)
                        print(\ExpenseItem.name)
                    }
                }
            }
            .navigationTitle("iExpense")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                Button("Add Expense", systemImage: "plus") {
                    let expense = ExpenseItem(name: "Test", type: "Personal", amount: 5)
                    expenses.items.append(expense)
                }
            }
        }
    }
}

struct ExpenseItem {
    let name: String
    let type: String
    let amount: Double
}

@Observable
class Expenses {
    var items = [ExpenseItem]()
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
