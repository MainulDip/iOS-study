//
//  SecondView.swift
//  Animations-6
//
//  Created by Mainul Dip on 12/17/23.
//

import SwiftUI

struct GestureAnimaitonBoxDrag : View {
    
    @State private var dragAmount = CGSize.zero
    
    var body: some View {
        VStack {
            LinearGradient(colors: [.yellow, .red], startPoint: .topLeading, endPoint: .bottomTrailing)
                .frame(width: 300, height: 200)
                .clipShape(RoundedRectangle(cornerRadius: 10))
                .offset(dragAmount)
                .gesture(
                    DragGesture()
                        .onChanged { dragAmount = $0.translation }
                        .onEnded { _ in
                            // this will allow to animate only the last part
                            withAnimation(.spring()) {
                                dragAmount = .zero
                            }
                            
                        }
                )
                // .animation(.easeInOut, value: dragAmount)
                // removing the both way animation with only onEnded part by withAnimation inside the callback
        }
    }
}

struct GestureAnimaitonBoxDrag_Preview: PreviewProvider {
    static var previews: some View {
        GestureAnimaitonBoxDrag()
    }
}
