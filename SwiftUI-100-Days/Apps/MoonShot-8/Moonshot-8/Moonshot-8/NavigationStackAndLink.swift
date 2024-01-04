//
//  NavigationStackAndLink.swift
//  Moonshot-8
//
//  Created by Mainul Dip on 1/4/24.
//

import SwiftUI

struct NavigationStackAndLink: View {
    var body: some View {
        NavigationStack {
            
            NavigationLink("Tap Me") {
                Text("Detail View")
            }
            
            NavigationLink {
                Text("Detail View")
            } label: {
                VStack {
                    Text("This is the label")
                    Text("So is this")
                    Image(systemName: "face.smiling")
                }
                .font(.largeTitle)
            }
            // .navigationTitle("Nav Detail")
            
            // NavigationLink inside List will show and right arrow to each item
            List(0..<100) { row in
                NavigationLink("Row \(row)") {
                    Text("Detail \(row)")
                }
            }
            .navigationTitle("SwiftUI")
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}

#Preview {
    NavigationStackAndLink()
}
