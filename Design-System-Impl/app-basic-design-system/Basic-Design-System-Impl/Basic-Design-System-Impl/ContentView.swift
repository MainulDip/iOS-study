//
//  ContentView.swift
//  Basic-Design-System-Impl
//
//  Created by Mainul Dip on 9/4/25.
//

import SwiftUI

struct ContentView: View {
    
    @Environment(\.designTokens) private var tokens
    
    var body: some View {
        VStack {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundStyle(.tint)
            Text("Hello, world!")
                .padding(tokens.spacing.buttonPadding)
                .font(tokens.typography.headlineLarge)
                .foregroundColor(tokens.colors.onSedondary)
                .background(tokens.colors.sedondary)
                .cornerRadius(tokens.spacing.radiusSm)
                
        }
        .padding()
        .background(tokens.colors.background)
    }
}

#Preview {
    ContentView()
}
