//
//  ContentView.swift
//  iExpense-7
//
//  Created by Mainul Dip on 12/18/23.
//

import SwiftUI

struct ContentView: View {
    /** Reading form UserDefaults
     * if the key can’t be found on first run
     *  it just sends back 0
     */
    @State private var tapCount = UserDefaults.standard.integer(forKey: "Tap")
    
    var body: some View {
        Button("Tap count: \(tapCount)") {
            tapCount += 1
            /* Setting UserDefault Value is a Key */
            UserDefaults.standard.set(tapCount, forKey: "Tap")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
