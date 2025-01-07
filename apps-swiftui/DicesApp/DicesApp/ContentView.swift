//
//  ContentView.swift
//  DicesApp
//
//  Created by Mainul Dip on 8/14/23.
//

import SwiftUI

struct ContentView: View {
    /*
     * @State Property Wrapper will make that property mutable
     * and will also any view using that property will be observed
     * and will be changed if the marked property changes
     */
    @State var leftDiceNum = 1
    @State var rightDiceNum = 1
    
    var body: some View {
        ZStack {
            Image("background")
                .resizable() // resizes/stretches an image to fit its space
                .edgesIgnoringSafeArea(.all)
            VStack {
                Spacer()
                Image("diceeLogo")
                Spacer()
                
                HStack {
                    DiceView(n: leftDiceNum)
                    DiceView(n: rightDiceNum)
                }
                .padding(.horizontal)
                
                Spacer()
                Button(action: {
                    // action to dd
                    print("rolling")
                    // @State property wrapper makes these property mutable
                    self.leftDiceNum = Int.random(in: 1...6)
                    self.rightDiceNum = Int.random(in: 1...6)
                    
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
