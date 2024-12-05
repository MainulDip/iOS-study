//
//  State-Basic.swift
//  WeSplit
//
//  Created by Mainul Dip on 12/5/24.
//

import SwiftUI

struct State_Basic: View {
    @State private var tapCount = 0
    
    var body: some View {
        Button("Tap Count: \(tapCount)") {
            self.tapCount += 1 // self is optional here
            if tapCount > 10 { // parenthesis around condition optional
                tapCount = 0
            }
        }
    }
}

#Preview {
    State_Basic()
}
