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
        .sheet(isPresented: $showingSheet){
            print("Calling onDismiss")
        } content : {
            SecondView(name: "@twostraws")
        }
    }
}

struct SecondView: View {
    
    // using @Environment wrapper for self destruction (this view)
    @Environment(\EnvironmentValues.dismiss) var dismiss
    
    // var dismissActionKeyPath: KeyPath<EnvironmentValues, DismissAction> = \EnvironmentValues.dismiss
    
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
