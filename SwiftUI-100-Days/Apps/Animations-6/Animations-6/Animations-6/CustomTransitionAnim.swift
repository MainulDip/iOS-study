//
//  CustomTransitionAnim.swift
//  Animations-6
//
//  Created by Mainul Dip on 12/18/23.
//

import SwiftUI

struct CustomTransitionAnim: View {
    
    @State private var isShowingRed = false
    
    var body: some View {
        VStack {
            Rectangle()
                .fill(.blue)
                .frame(width: 200, height: 200)
            
            if isShowingRed {
                Rectangle()
                    .fill(.red)
                    .frame(width: 200, height: 200)
                    .transition(.pivot)
            }
        }
        .onTapGesture {
            withAnimation {
                isShowingRed.toggle()
            }
        }
    }
}

/* Define Custom Modifier */
struct CornerRotateModifier: ViewModifier {
    let amount: Double
    let anchor: UnitPoint
    
    func body(content: Content) -> some View {
        content
            .rotationEffect(.degrees(amount), anchor: anchor)
            .clipped()
    }
}

/* Define extension on AnyTransition */
extension AnyTransition {
    static var pivot: AnyTransition {
        .modifier(
            active: CornerRotateModifier(amount: -90, anchor: .topLeading),
            identity: CornerRotateModifier(amount: 0, anchor: .topLeading)
        )
    }
}

struct CustomTransitionAnim_Previews: PreviewProvider {
    static var previews: some View {
        CustomTransitionAnim()
    }
}
