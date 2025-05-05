//
//  PreferenceOnButtonPress.swift
//  Combine-Networking-Basics-3nd
//
//  Created by Mainul Dip on 5/4/25.
//

import Foundation
import SwiftUI

/*
 here preference key is used to update parents state
 from the child
 the .preference modifier call on the child's text view
 will setup the observation on the text @State
 and updating that will be listen on the parent using .onPreferenceChange
 */

struct MyPreferenceKey: PreferenceKey {
    static var defaultValue: String = ""
    
    static func reduce(value: inout String, nextValue: () -> String) {
        value = nextValue()
    }
}

struct PreferenceOnButtonPress: View {
    @State private var topLevelText: String = "Initial Text Top Level"
    
    var body: some View {
        VStack {
            Text("topLevelText: \(topLevelText)")
            ChildView(text: "Old Text For Child")
        }
        .onPreferenceChange(MyPreferenceKey.self) { newValue in
            print("Preference updated: \(newValue)")
            topLevelText += newValue // adding all text
            // topLevelText = newValue
        }
    }
}

struct ChildView: View {
    @State var text: String
    var body: some View {
        VStack {
            Text(text)
             .preference(key: MyPreferenceKey.self, value: text)
            // multiple preference can be used for final equation for each View
            Button("Update Preference") {
                text = "\(Int.random(in: 1..<100))"
                print("Updating from child")
            }
        }
    }
}

#Preview {
    PreferenceOnButtonPress()
}


/*
 
 struct PreferenceOnButtonPress: View {
 @State private var value: String = ""
 
 var body: some View {
 VStack {
 Button("Update Preference") {
 value = "New Value"
 }
 ChildView()
 }
 .preference(key: MyPreferenceKey.self, value: value)
 .onPreferenceChange(MyPreferenceKey.self) { newValue in
 print("Preference updated: \(newValue)")
 }
 }
 }
 
 struct ChildView: View {
 @State private var preferenceValue: String = ""
 
 var body: some View {
 Text(preferenceValue)
 .onPreferenceChange(MyPreferenceKey.self) { newValue in
 preferenceValue = newValue
 }
 }
 }
 
 */
