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
            Color(.lightGray)
                .edgesIgnoringSafeArea(.all)
            VStack {
                        Image(systemName: "globe")
                            .imageScale(.large)
                            .foregroundColor(.accentColor)
                        Text("Hello, world!")
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
