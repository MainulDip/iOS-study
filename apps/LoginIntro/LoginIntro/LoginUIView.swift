//
//  LoginUIView.swift
//  LoginIntro
//
//  Created by kaka beautha on 5/9/23.
//

import SwiftUI

struct LoginUIView: View {
    
    @State var email: String = "";
    @State var password: String = "";
    
    var body: some View {
        
        VStack {
            Spacer()
    
            Section (header: Text("Login Form") ) {
                Form {
                    TextField("Email", text: $email)
                    SecureField("Password", text: $password)
                }
            }
            
            Section {
                Button(action: {
                    print("Loging Now")
                }) {
                    Text("Button")
                }
            }
            
            Spacer() // available ios 13.0 +
            
        }
    }
}

struct LoginUIView_Previews: PreviewProvider {
    static var previews: some View {
        LoginUIView()
    }
}
