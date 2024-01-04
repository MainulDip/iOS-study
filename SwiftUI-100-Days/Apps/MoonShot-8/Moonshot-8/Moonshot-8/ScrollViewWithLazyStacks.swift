//
//  ScrollViewWithLazyStacks.swift
//  Moonshot-8
//
//  Created by Mainul Dip on 1/3/24.
//

import SwiftUI

struct ScrollViewWithLazyStacks: View {
    var body: some View {
        VStack {
            ScrollView (showsIndicators: false) { // to hide scrollbar
                LazyVStack(spacing: 10) {
                    ForEach(0..<100) {
                        CustomText("Item \($0)", $0)
                            .font(.title)
                    }
                }
                .frame(maxWidth: .infinity) // without this, drag on empty space will not scroll
            }
            
            VStack{
                Text("Some Text Under the ScrollView")
                    .padding(.top, 20)
            }
        }
    }
}

/**
 * Checking How LazyVStack/LazyHStack vs regular Stack's initilization policy
 * lazy's are initialized onDemand, and regulars are initialized all at once
 */
struct CustomText: View {
    let text: String
    let counter: Int

    var body: some View {
        Text(text)
    }

    // if init block is explicit, assignment instruction of  empty stored Properties are required inside of it.
    // for implicit case, swift will generate the init block behind the 
    init(_ text: String, _ counter: Int) {
        print("Creating a new CustomText, counter: \(counter)")
        self.text = text
        self.counter = counter
    }
}

#Preview {
    ScrollViewWithLazyStacks()
}
