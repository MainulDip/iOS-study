//
//  ContentView.swift
//  HackerNews
//
//  Created by Mainul Dip on 8/16/23.
//

import SwiftUI

struct ContentView: View {
    @ObservedObject var networkResult = NetworkManager()
    
    var body: some View {
        NavigationView {
            VStack(alignment: .leading, spacing: 0) {
                List(networkResult.res) { post in
                    Text("\(post.points): \(post.title)")
                }
            }
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .principal) {
                    HStack {
                        Image(systemName: "sun.min.fill")
                        Text("Title").font(.headline)
                    }
                }
            }
            
        }
        .onAppear {
            networkResult.fetchUrl()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
