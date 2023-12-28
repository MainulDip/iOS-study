//
//  ClassStateObservable.swift
//  iExpense-7
//
//  Created by Mainul Dip on 12/28/23.
//

import SwiftUI
import Observation

struct ClassStateObservable: View {
    @State private var user = User()
    
    var body: some View {
        Form {
            Text("Your name is \(user.firstName) \(user.lastName).")
            
            TextField("First name", text: $user.firstName)
            
            TextField("Last name", text: $user.lastName)
        }
    }
}

@Observable
class User {
    var firstName  = "Bilbo"
    var lastName = "Baggins"
}

#Preview {
    ClassStateObservable()
}
