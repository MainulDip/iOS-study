//
//  PreferenceSystem.swift
//  Combine-Networking-Basics-3nd
//
//  Created by Mainul Dip on 5/3/25.
//

import SwiftUI

struct PreferenceKeyEg: View {
    @State private var secondScreenText: String = "Hello World"
    var body: some View {
        NavigationView {
            VStack {
                SecondScreen(text: secondScreenText)
                    .preference(key: CustomTitlePreferenceKey.self, value: secondScreenText)
                
                Button("Change Text") {
                    CustomTitlePreferenceKey.defaultValue = "Hello from First Screen Changed"
                    
                }
            }
        }
        .navigationTitle("Navigaiton Title")
        .onPreferenceChange(CustomTitlePreferenceKey.self) { value in
            secondScreenText = value
        }
    }
}

struct SecondScreen: View {
    let text: String
    var body: some View {
        Text(text)
    }
}

struct CustomTitlePreferenceKey: PreferenceKey {
    static var defaultValue: String = "Default Text for Second Screen"
    
    static func reduce(value: inout String, nextValue: () -> String) {
        value = nextValue()
    }
}

// add preview
#Preview {
    PreferenceKeyEg()
}
