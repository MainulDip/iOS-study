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
    
    let types = ["Business", "Personal"]
    @Environment(\.locale) private var local
    
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
        }
    }
}

#Preview {
    AddView()
}
