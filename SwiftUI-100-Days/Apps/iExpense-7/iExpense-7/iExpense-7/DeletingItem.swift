//
//  DeletingItem.swift
//  iExpense-7
//
//  Created by Mainul Dip on 12/28/23.
//

import SwiftUI

struct DeletingItem: View {
    @State private var numbers = [Int]()
    @State private var currentNumber = 1
    
    var body: some View {
       NavigationStack {
            VStack {
                List {
                    ForEach(numbers, id: \.self) {
                        Text("Row \($0)")
                    }
                    .onDelete(perform: { indexSet in
                        numbers.remove(atOffsets: indexSet)
                    })
                }
                
                Button("Add Number") {
                    numbers.append(currentNumber)
                    currentNumber += 1
                }
            }
            .toolbar(content: {
                EditButton()
            })
        }
    }
}

#Preview {
    DeletingItem()
}
