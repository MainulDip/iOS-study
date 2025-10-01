//
//  SecondView.swift
//  Animations-6
//
//  Created by Mainul Dip on 12/17/23.
//

import SwiftUI

struct GestureAnimaitonBoxDrag : View {
    
    @State private var dragAmount = CGSize.zero
    
    @State var someArr = Array(0..<100)
    
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
            
            List {
                Text("Hello, World!")
                
                ForEach(someArr, id: \.self) { i in Text("\(i)") }
                    .onDelete { indexSet in
                        print("Deleted number is \(someArr[Array(indexSet)[0]])")
                        
                        for (index, element) in indexSet.enumerated() {
                            print("Selected index: \(index) and current element index: \(element)")
                        }
                        
                        someArr = someArr.filter { !indexSet.contains($0) }
                    }
            }
        }
    }
}

struct GestureAnimaitonBoxDrag_Preview: PreviewProvider {
    static var previews: some View {
        GestureAnimaitonBoxDrag()
    }
}
