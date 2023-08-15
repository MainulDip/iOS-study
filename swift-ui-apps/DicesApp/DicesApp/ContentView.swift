//
//  ContentView.swift
//  DicesApp
//
//  Created by Mainul Dip on 8/14/23.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        ZStack {
            Image("background")
                .resizable() // resizes/stretches an image to fit its space
                .edgesIgnoringSafeArea(.all)
            VStack {
                Image("diceeLogo")
                HStack {
                    DiceView(n: 1)
                    DiceView(n: 2)
                }
                .padding(.horizontal)
                Button(action: {
                    // action to dd
                    print("rolling")
                }, label: {
                    ZStack {
                        Text("Roll")
                            .font(.system(size: 47))
                            .padding(.horizontal)
                            .foregroundColor(.white)
                    }.background(Color.red)
                })
            }
            .padding()
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color.green)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

struct DiceView: View {
    let n: Int
    var body: some View {
        Image("dice\(n)")
            .resizable()
            .aspectRatio(1, contentMode: .fit)
    }
}
