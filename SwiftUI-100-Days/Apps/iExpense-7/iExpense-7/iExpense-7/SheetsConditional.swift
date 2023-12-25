//
//  SheetsConditional.swift
//  iExpense-7
//
//  Created by Mainul Dip on 12/23/23.
//

import SwiftUI

struct SheetsConditional: View {
    
    @State private var showingSheet = false
    
    var body: some View {
        Button("Show Sheet") {
            showingSheet.toggle()
        }
        .sheet(isPresented: $showingSheet) {
            SecondView(name: "@twostraws")
        }
    }
}

struct SecondView: View {
    
    // using @Environment wrapper for self destruction (this view)
    @Environment(\.dismiss) var dismiss
    
    let name: String
    
    var body: some View {
        VStack {
            Text("Hello, \(name)!")
            Button("Dismiss") {
                dismiss()
            }
        }
    }
}

#Preview {
    SheetsConditional()
}
