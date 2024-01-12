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
    
    let missions: [Mission] = Bundle.main.decode("missions.json")
    
    var body: some View {
        VStack {
            
            Spacer()
            
            Text("All the Astronust are \(astronauts.keys.joined(separator: ", ").capitalized)")
            
            Spacer().frame(height: 40)
            
            Text("Total mission count is \(missions.count)")
            
            Spacer()
        }
        .padding(20)
    }
}

#Preview {
    ContentView()
}
