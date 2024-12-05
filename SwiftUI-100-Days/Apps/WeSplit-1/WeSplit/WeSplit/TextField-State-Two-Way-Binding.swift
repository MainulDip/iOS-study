//
//  TextField-State-Two-Way-Binding.swift
//  WeSplit
//
//  Created by Mainul Dip on 12/5/24.
//

import SwiftUI

struct TextField_State_Two_Way_Binding: View {
    @State private var name = ""
    var body: some View {
        TextField("Name:", text: $name)
            .padding([Edge.Set.horizontal], 40)
            .foregroundColor(.blue)
            .keyboardType(.asciiCapable)
            .font(.largeTitle)
    }
}

#Preview {
    TextField_State_Two_Way_Binding()
}
