//
//  ContentView.swift
//  WeSplit
//
//  Created by Mainul Dip on 12/12/23.
//

import SwiftUI

struct ContentView: View {
    
    let students = ["Harry", "Hermione", "Ron"]
    @State private var selectedStudent = "Harry"
    
    @State private var tapCount = 0
    
    @State private var name = ""
    
    var body: some View {
        
        NavigationStack {
            Form {
                
                Section {
                    TextField("Enter Your Name", text: $name)
                    Text("Hello, World by \(name)")
                }
                
                
                Section {
                    Picker("Select your Student", selection: $selectedStudent) {
                        ForEach(students, id: \.self) {
                            Text($0)
                        }
                    }
                }
            }
            .navigationTitle("SwiftUI")
            .navigationBarTitleDisplayMode(.inline)
            
            Button("Tap Count: \(tapCount)") {
                self.tapCount += 1
            }
            Button("Tap Count: \(tapCount)") {
                self.tapCount += 1
            }
        }
        
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
