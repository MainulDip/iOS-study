//
//  UserDefaultsStorage.swift
//  iExpense-7
//
//  Created by Mainul Dip on 12/28/23.
//

import SwiftUI

struct UserDefaultsStorage: View {
    /** Reading form UserDefaults
     * if the key can’t be found on first run
     *  it just sends back 0
     */
    @State private var tapCount = UserDefaults.standard.integer(forKey: "Tap")
    
    var body: some View {
        Button("Tap count: \(tapCount)") {
            tapCount += 1
            /* Setting UserDefault Value is a Key */
            UserDefaults.standard.set(tapCount, forKey: "Tap")
        }
    }
}

#Preview {
    UserDefaultsStorage()
}
