//
//  ContactBtn.swift
//  BusinessCard
//
//  Created by Mainul Dip on 8/14/23.
//

import SwiftUI

struct ContactBtn: View {
    let sysIcon: String
    let infoTexts: String
    
    var body: some View {
        RoundedRectangle(cornerRadius: 10.0)
            .fill(.white)
            .frame(height: 47.0)
            .overlay(HStack {
                Image(systemName: sysIcon)
                    .foregroundColor(.blue)
                Text(infoTexts)
            })
    }
}

struct ContactBtn_Previews: PreviewProvider {
    static var previews: some View {
        ContactBtn(sysIcon: "link", infoTexts: "Some Text").previewLayout(.sizeThatFits)
    }
}
