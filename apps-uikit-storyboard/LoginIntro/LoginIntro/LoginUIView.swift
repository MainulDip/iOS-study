import SwiftUI

struct LoginUIView: View {
    
    @State var email: String = "";
    @State var password: String = "";
    
    @State var goToMain: Bool = false;
    
    var body: some View {
        
        NavigationView {
        
            VStack {
                
            NavigationLink(
                destination: MainView(),
                isActive: $goToMain,
                label: {
                    EmptyView()
                })
            
            
            HStack {
                Spacer()
                Text("Login Form")
                    .font(.title3)
                    .fontWeight(.bold)
                    .foregroundColor(Color.blue)
                
                Spacer()

            }
            
            Form {
                
                Section {
                    TextField("Email", text: $email)
                    SecureField("Password", text: $password)
                }
                
                Section {
                    HStack {
                        Spacer()
                        
                        Button(action: {
                                
                            print("\(email) \(password)")
                            goToMain = true;
                            
                        }) {
                            Text("Login")
                                .fontWeight(.bold)
                                .foregroundColor(Color.orange)
                                .font(/*@START_MENU_TOKEN@*/.callout/*@END_MENU_TOKEN@*/)
                            
                            
                        }
                        
                        Spacer()
                    }
                    
                    HStack {
                        List {
                            Spacer()
                            Text("Register")
                                .overlay(
                                    NavigationLink(
                                        destination: RegisterView()) {
                                        EmptyView();
                                    }
                                )
                                .foregroundColor(/*@START_MENU_TOKEN@*/.blue/*@END_MENU_TOKEN@*/)
                            Spacer()
                        }
                    }
                    
                }
                
//                Section {
//                    HStack {
//                        NavigationLink(
//                            destination: RegisterView(),
//                            label: {
//                                Spacer()
//                                Text("Register")
//                                    .foregroundColor(Color.blue)
//                                Spacer()
//                            }
//                        )
//
//                        /***
//                         * Navigation Without Trailing Arrow
//                         */
//
//                        List {
//                            Spacer()
//                            Text("Register")
//                                .overlay(
//                                    NavigationLink(
//                                        destination: RegisterView()) {
//                                        EmptyView()
//                                    }
//                                )
//                                .foregroundColor(/*@START_MENU_TOKEN@*/.blue/*@END_MENU_TOKEN@*/)
//                            Spacer()
//                        }
//                    }
//                }
            }
            
        }
        }
        .navigationBarHidden(true)
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
//                                            .font(.title) 1
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
