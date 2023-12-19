//
//  ConditionalViewToggleAnim.swift
//  Animations-6
//
//  Created by Mainul Dip on 12/18/23.
//

import SwiftUI

struct ConditionalViewToggleAnim: View {
    
    // @State var isShowingRed: Bool
    @State var isShowingRed = false
    
    /*
        init () {
     
         /**
          * if any member is not assigned with value and not a computed property then
          * the property needs to either be assaign in init block or as constructor parameter while instantiating
          */
     
         isShowingRed = false
        
     }
    */
    
    var body: some View {
        VStack {
            Button("Tap Me") {
                withAnimation {
                    isShowingRed.toggle()
                }
            }
            
            if isShowingRed {
                Rectangle()
                    .fill(.red)
                    .frame(width: 200, height: 200)
                    // .transition(.scale)
                    .transition(.asymmetric(insertion: .scale, removal: .opacity))
            }
        }
        
    }
}

struct ConditionalViewToggleAnim_Previews: PreviewProvider {
    static var previews: some View {
        ConditionalViewToggleAnim()
    }
}
