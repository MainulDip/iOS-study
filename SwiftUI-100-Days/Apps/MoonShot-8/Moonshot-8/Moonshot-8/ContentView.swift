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
    
    let columns = [
        GridItem(.adaptive(minimum: 150))
    ]
    
    var body: some View {
        VStack(spacing: 40) {
            
            Text("All the Astronust are \(astronauts.keys.joined(separator: ", ").capitalized)")
            
//            Spacer()
            
            Text("Total mission count is \(missions.count)")
        }
        .frame(maxHeight: .infinity, alignment: .center)
        .padding(20)
    }
}

#Preview {
    ContentView()
}
