//
//  ContentView.swift
//  GuessTheFlag
//
//  Created by Mainul Dip on 12/13/23.
//

import SwiftUI

/**
 * A Screen With Fill with Red Color, including safe area and
 * 2 Vertical Rows  each with 2 Horizontal Columns
 * the order of modifier matters like
 * padding will not work if placed after backgorund
 */

struct ContentView: View {
    var body: some View {
        ZStack {
            Color.red.edgesIgnoringSafeArea(.all) // same as .ignoresSafeArea()
            VStack(spacing: 20) {
                HStack(spacing: 20) {
                    Text("Your content 1").padding(10).background(Color.orange)
                    Text("||")
                    Text("Your content 2").padding(10).background(Color.cyan)
                }
                .background(Color.white)
                .cornerRadius(10) // round corner
                
                HStack(spacing: 20) {
                    Text("Your content 3")
                    Text("||")
                    Text("Your content 4")
                }
                .padding(20) // the order of padding and background matters, will not work if placed after backgorund
                .background(Color.white)
                .cornerRadius(10)
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
