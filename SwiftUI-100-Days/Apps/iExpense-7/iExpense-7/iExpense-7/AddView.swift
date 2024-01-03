//
//  AddView.swift
//  iExpense-7
//
//  Created by Mainul Dip on 1/1/24.
//

import SwiftUI

struct AddView: View {
    
    @State private var name = ""
    @State private var type = "Personal"
    @State private var amount = 0.0
    
    var expenses: Expenses
    // expense instance will be injected through the ContentView, so appending will reflect there as well
    
    let types = ["Business", "Personal"]
    
    @Environment(\.locale) private var local
    @Environment(\.dismiss) private var dismissThisView
    
    var body: some View {
        NavigationStack {
            Form {
                
                TextField("Name", text: $name)
                
                Picker("Type", selection: $type) {
                    ForEach(types, id: \.self) {
                        Text($0)
                    }
                }
                
                TextField("Amount", value: $amount, format: .currency(code: local.currency?.identifier ?? "USD")) // user's local currency code
            }
            .navigationTitle("Add Expense")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                Button("Save") {
                    let item = ExpenseItem(name: name, type: type, amount: amount)
                    expenses.items.append(item) // expense instance is injected through the ContentView, so appending will reflect there
                    dismissThisView()
                    
                }
            }
        }
    }
}

#Preview {
    AddView(expenses: Expenses())
}
