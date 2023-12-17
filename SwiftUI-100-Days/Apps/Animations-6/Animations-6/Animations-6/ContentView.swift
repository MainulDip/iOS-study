//
//  ContentView.swift
//  Animations-6
//
//  Created by Mainul Dip on 12/17/23.
//

import SwiftUI

struct ContentView: View {
    
    @State private var animationAmount = 1.0
    
    var body: some View {
        VStack {
            Button("Tap Me") {
                if(animationAmount < 4) {
                    animationAmount += 1
                } else {
                    animationAmount = 1
                }
            }
            .padding(50)
            .background(.red)
            .foregroundStyle(.white)
            .clipShape(Circle())
            .scaleEffect(animationAmount) // will scale the Button 1x, 2x, 3x, etc
            .animation(.default, value: animationAmount) // animate the value of `animationAmount`
        }
        .padding()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
