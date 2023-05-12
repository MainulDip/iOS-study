//
//  RegisterView.swift
//  LoginIntro
//
//  Created by kaka beautha on 5/12/23.
//

import SwiftUI

struct RegisterView: View {
    
    @State var firstName: String = "";
    @State var lastName: String = "";
    @State var email: String = "";
    @State var password: String = "";
    @State var confirmPassword: String = "";
    
    var body: some View {
        
        NavigationView {
        
            VStack (alignment: .center) {
        
        
                HStack {
                    Spacer()
                    Text("Register Account")
                        .font(.title3)
                        .fontWeight(.bold)
                        .foregroundColor(Color.blue)
                    Spacer()
                    
                }
                
                Form {
                    
                    Section {
                        TextField("First Name", text: $firstName)
                        TextField("Last Name", text: $lastName)
                        TextField("Email", text: $email)
                        SecureField("Password", text: $password)
                        SecureField("Confirm Password", text: $confirmPassword)
                    }
                    
                    Section {
                        HStack {
                            Spacer()
                            
                            Button(action: { print("\(email) \(password)") }) {
                                Text("Register")
                                    .fontWeight(.bold)
                                    .foregroundColor(Color.orange)
                                    .font(/*@START_MENU_TOKEN@*/.callout/*@END_MENU_TOKEN@*/)
                            }
                            
                            Spacer()
                        }
                        
                    }
                    
                    Section {
                        HStack {
                            NavigationLink(
                                destination: LoginUIView(),
                                label: {
                                    Spacer()
                                    Text("Login")
                                        .foregroundColor(Color.blue)
                                    Spacer()
                                })
                        }
                    }
                }
            }
            
        }
        .navigationBarHidden(true)
    }
}

struct RegisterView_Previews: PreviewProvider {
    static var previews: some View {
        RegisterView()
    }
}
