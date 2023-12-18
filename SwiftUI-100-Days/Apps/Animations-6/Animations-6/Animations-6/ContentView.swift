//
//  ContentView.swift
//  Animations-6
//
//  Created by Mainul Dip on 12/17/23.
//

import SwiftUI

struct ContentView: View {
    
    @State private var animationAmount = 1.0
    @State private var startAnim = false
    @State private var enabled = false
    
    var body: some View {
        VStack {
            Button("Tap Me") {
//                if(animationAmount < 4) {
//                    animationAmount += 1
//                } else {
//                    animationAmount = 1
//                }
                
//                withAnimation {
//                    animationAmount += 360
//                }
                
//                withAnimation(.spring(response: 2, dampingFraction: 1)) {
//                    animationAmount += 360
//                }
                enabled.toggle()
            }
            .padding(50)
            .background(enabled ? .red : .blue)
            .foregroundStyle(.white)
            .animation(.easeInOut(duration: 1), value: enabled)
            .clipShape(RoundedRectangle(cornerRadius: enabled ? 60 : 0))
            .animation(.spring(response: 1, dampingFraction: 1), value: enabled)
//            .clipShape(Circle())
//            .scaleEffect(animationAmount) // will scale the Button 1x, 2x, 3x, etc
//            .blur(radius: (animationAmount - 1) * 3)
//            .onAppear {
//                animationAmount = 2
//                startAnim = true
//                withAnimation (.default.repeatCount(7)) {
//                    animationAmount += 360
//                }
//            }
//            .overlay(
//                Circle()
//                    .stroke(.red)
//                    .scaleEffect(animationAmount + 1)
//                    .opacity(2 - animationAmount)
//                    .animation(
//                        .easeOut(duration: 1)
//                        .repeatForever(autoreverses: false),
//                        value: animationAmount
//                    )
//            )
//            .animation(.default, value: animationAmount) // animate the value of `animationAmount`
            .rotation3DEffect(.degrees(animationAmount), axis: (x: 0, y: 1, z: 0))
        }
        .padding()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
