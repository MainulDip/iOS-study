//
//  ContentView.swift
//  BusinessCard
//
//  Created by Mainul Dip on 8/12/23.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        ZStack {
            Color(red: 0.27, green: 0.76, blue: 0.97)
                .edgesIgnoringSafeArea(.all)
            VStack {
                Image("mainuldip")
                    .resizable(resizingMode: .stretch)
                    .frame(width: 200.0, height: 200.0)
                    .clipShape(Circle())
                    .overlay(Circle().stroke(Color.white, lineWidth:  7.0))
                
                Text("Mainul Dip").foregroundColor(.black)
                    .font(Font.custom("Cinzel Decorative", size: 40.0))
                    .padding(.vertical)
                
                Text("Software Developer | Full Stack")
                    .foregroundColor(.black)
                Text("( Web | iOS | Android | AI/ML )")
                    .foregroundColor(.black)
                
                Divider()
                
                ProfieInfo(sysIcon: "phone.fill", infoTexts: "+1 1234567890")
                
                ProfieInfo(sysIcon: "link", infoTexts: "websolverpro.com")
            }
            .padding()
        }
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

struct ProfieInfo: View {
    
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
