//
//  ContentView.swift
//  BusinessCard
//
//  Created by Mainul Dip on 8/12/23.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        ZStack {
            Color(red: 0.27, green: 0.76, blue: 0.97)
                .edgesIgnoringSafeArea(.all)
            VStack {
                Image(systemName: "globe")
                    .imageScale(.large)
                    .foregroundColor(.accentColor)
                Text("Mainul Dip").foregroundColor(.black)
                    .font(Font.custom("Cinzel Decorative", size: 40.0))
                    .padding(.vertical)
                
                
            }
            .padding()
        }
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
