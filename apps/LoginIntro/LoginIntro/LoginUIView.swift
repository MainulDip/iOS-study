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
        
        VStack (alignment: .center) {
        
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
            
        }.ignoresSafeArea()
    }
    
// Centering Vertical
//    var body: some View {
//            ZStack {
//                Color.green
//                    .edgesIgnoringSafeArea(.all)
//
//                VStack(spacing: 16) {
//                    Color.clear
//                        .overlay(
//                            VStack {
//                                Image(systemName: "clock")
//                                    .resizable()
//                                    .foregroundColor(.white)
//                                    .aspectRatio(contentMode: .fit)
//                                    .frame(width: 156, height: 80)
//                                Color.clear
//                                    .overlay(
//                                        Text("My\nmultiline label")
//                                            .multilineTextAlignment(.center)
//                                            .font(.title)
//                                            .foregroundColor(.white)
//                                )
//                            }
//                        )
//                    RoundedRectangle(cornerRadius: 5).fill(Color.white).frame(height: 79)
//                    RoundedRectangle(cornerRadius: 5).fill(Color.white).frame(height: 79)
//                    Color.clear
//                }
//                .padding([.leading, .trailing], 24)
//            }
//        }
}

struct LoginUIView_Previews: PreviewProvider {
    static var previews: some View {
        LoginUIView()
    }
}
