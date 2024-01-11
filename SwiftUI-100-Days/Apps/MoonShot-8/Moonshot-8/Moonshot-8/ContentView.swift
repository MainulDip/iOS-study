//
//  ContentView.swift
//  Moonshot-8
//
//  Created by Mainul Dip on 1/3/24.
//

import SwiftUI

struct ContentView: View {
    
    // specifying dictionary type
    let astronauts: [String: Astronaut] = Bundle.main.decode("astronauts.json")
    
    var body: some View {
        Text("All the Astronust are \(astronauts.keys.joined(separator: ", ").capitalized)")
    }
}

#Preview {
    ContentView()
}
