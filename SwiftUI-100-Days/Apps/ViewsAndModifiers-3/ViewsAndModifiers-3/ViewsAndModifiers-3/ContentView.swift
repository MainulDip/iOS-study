//
//  ContentView.swift
//  ViewsAndModifiers-3
//
//  Created by Mainul Dip on 12/13/23.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        
        VStack {
            // custom stack based container
            CustomGridStack(rows: 4, columns: 3) { row, col in
                Image(systemName: "\(row * 4 + col).circle")
                Text("R\(row) C\(col)")
            }
            
            // custom modifier applied
            HStack {
                Text("Hello World")
                    .myCustomStyle()
            }
        }
        
        
        
//        VStack {
//             VStack {
//                 Text("Gryffindor")
//                     .font(.largeTitle)
//                 Text("Hufflepuff")
//                 Text("Ravenclaw")
//                 Text("Slytherin")
//             }
//             .font(.title)
//
//             VStack {
//                 Text("Gryffindor")
//                     .blur(radius: 1)
//                 Text("Hufflepuff")
//                 Text("Ravenclaw")
//                 Text("Slytherin")
//             }
//             .blur(radius: 6)
//         }
        
        
//       VStack {
//            Text("Hello, world!")
//                .background(.red)
//            Button("Click") {
//                print(type(of: self.body))
//            }
//        }
        
        // ModifiedContent<Text, _BackgroundStyleModifier<Color>>
//        VStack {
//            Image(systemName: "globe")
//                .imageScale(.large)
//                .foregroundStyle(.tint)
//            ZStack {
//                Text("Hello, world!")
//            }
//            .frame(maxWidth: .infinity)
//            .background(.red)
//
//            Button("Hello, world!") {
//                print(type(of: self.body))
//            }
////            .background(.red)
//            .frame(width: 200, height: 200)
//
//        }
//        .frame(maxWidth: .infinity, maxHeight: .infinity)
//        .background(.red)
        
       
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

extension View {
    func myCustomStyle() -> some View {
        modifier(MyCustoModifier())
    }
}

struct MyCustoModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.largeTitle)
            .foregroundStyle(.white)
            .padding()
            .background(.blue)
            .cornerRadius(10)
    }
}

// Custom Stack Container Defination
struct CustomGridStack<Content: View>: View {
    let rows: Int
    let columns: Int
    // let content: (Int, Int) -> Content
    // adds more flexibility to return multiple view with @ViewBuilder wrapper, so we don't need to place the content inside another Stack to return multiple view when applying
    @ViewBuilder let content: (Int, Int) -> Content

    var body: some View {
        VStack {
            ForEach(0..<rows, id: \.self) { row in
                HStack {
                    ForEach(0..<columns, id: \.self) { column in
                        content(row, column)
                    }
                }
            }
        }
    }
}
