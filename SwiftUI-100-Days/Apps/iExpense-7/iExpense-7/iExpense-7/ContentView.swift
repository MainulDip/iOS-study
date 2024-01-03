//
//  ContentView.swift
//  iExpense-7
//
//  Created by Mainul Dip on 12/18/23.
//

import SwiftUI

let EXPENSES_USER_DEFAULT_KEY = "EXPENSES_USER_DEFAULT_KEY"

struct ContentView: View {
    
    @State private var expenses = Expenses()
    @State private var showingAddExpense = false
    
    var body: some View {
        NavigationStack {
            List {
                ForEach(expenses.items) { item in
//                    Text(item.name)
                    HStack {
                            VStack(alignment: .leading) {
                                Text(item.name)
                                    .font(.headline)
                                Text(item.type)
                            }
                        
                        Spacer()
                        Text(item.amount, format: .currency(code: Locale.current.currency?.identifier ?? "USD"))
                        // also possible with @Environment(\.locale)
                    }
                }
                .onDelete(perform: removeItems)
            }
            .navigationTitle("iExpense")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                Button("Add Expense", systemImage: "plus") {
                    //                    let expense = ExpenseItem(name: "Test", type: "Personal", amount: 5)
                    //                    expenses.items.append(expense)
                    showingAddExpense = true
                }
            }
        }
        .sheet(isPresented: $showingAddExpense) {
            AddView(expenses: expenses)
        }
    }
    
    func removeItems(at offsets: IndexSet) {
        expenses.items.remove(atOffsets: offsets)
    }
}

struct ExpenseItem: Identifiable, Codable {
    var id: UUID = UUID()
    let name: String
    let type: String
    let amount: Double
}

@Observable
class Expenses {
    // empty array can also possible like -> items = [ExpenseItem](), type will be infered automatically
    var items: [ExpenseItem] = [] {
        didSet {
            if let encoded = try? JSONEncoder().encode(items) {
                UserDefaults.standard.set(encoded, forKey: EXPENSES_USER_DEFAULT_KEY)
            }
        }
    }
    
    init() {
        if let savedItems = UserDefaults.standard.data(forKey: EXPENSES_USER_DEFAULT_KEY) {
            if let decodedItems = try? JSONDecoder().decode([ExpenseItem].self, from: savedItems) {
                items = decodedItems
                return
            }
            
            items = []
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
