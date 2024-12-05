//
//  Practice-01.swift
//  WeSplit
//
//  Created by Mainul Dip on 12/3/24.
//

import SwiftUI

struct Practice_01: View {
    
    
    let students = ["Harry", "Hermione", "Ron"]
    @State private var selectedStudent = "Harry"
    
    var body: some View {
        NavigationStack {
            Form {
                Picker("Select your student", selection: $selectedStudent) {
                    ForEach(students, id: \.self) {
                        Text($0)
                    }
                }
            }
            .navigationTitle("Navigatiron Titile")
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}

#Preview {
    Practice_01()
}
