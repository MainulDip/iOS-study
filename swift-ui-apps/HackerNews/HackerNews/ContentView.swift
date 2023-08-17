//
//  ContentView.swift
//  HackerNews
//
//  Created by Mainul Dip on 8/16/23.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        NavigationView {
            List(posts) { post in
                Text("\(post.id): \(post.title)")
            }
        }
        .navigationBarTitle("Hacker News")
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}


let posts: [Post] = [
//    Post(id: "1", title: "Hello"),
//    Post(id: "2", title: "Bonjour"),
//    Post(id: "3", title: "Hola")
]
