//
//  ContentView.swift
//  Async-Await-API-SwiftUI-First
//
//  Created by Mainul Dip on 3/27/25.
//

import SwiftUI

struct ContentView: View {
    
    var body: some View {
        VStack {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundStyle(.tint)
            Text("Hello, world!")
        }
        .padding()
        .background(Color.orange, in: RoundedRectangle(cornerRadius: 4))
    }
}

#Preview {
    ContentView()
}
