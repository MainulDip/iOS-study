//
//  ContentView.swift
//  BetterRest-4
//
//  Created by Mainul Dip on 12/14/23.
//

import SwiftUI

struct ContentView: View {
    
    @State private var sleepAmount = 7.0
    
    var body: some View {
        VStack {
            Stepper("\(sleepAmount.formatted()) hours", value: $sleepAmount, in: 4...12, step: 0.25)
        }
        .padding()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
