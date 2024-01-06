//
//  ContentView.swift
//  Moonshot-8
//
//  Created by Mainul Dip on 1/3/24.
//

import SwiftUI

struct ContentView: View {
    
    let astronauts = Bundle.main.decode("astronauts.json")
    
    var body: some View {
        Text("Total Astronauts is \(astronauts.count)")
    }
}

#Preview {
    ContentView()
}
