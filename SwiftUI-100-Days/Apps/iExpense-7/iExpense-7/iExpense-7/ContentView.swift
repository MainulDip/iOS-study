//
//  ContentView.swift
//  iExpense-7
//
//  Created by Mainul Dip on 12/18/23.
//
import SwiftUI

struct ContentView: View {
    @State private var user = User()

        var body: some View {
            Form {
                Text("Your name is \(user.firstName) \(user.lastName).")

                TextField("First name", text: $user.firstName)
                
                TextField("Last name", text: $user.lastName)
            }
        }
}

class User {
    var firstName = "Bilbo"
    var lastName = "Baggins"
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
