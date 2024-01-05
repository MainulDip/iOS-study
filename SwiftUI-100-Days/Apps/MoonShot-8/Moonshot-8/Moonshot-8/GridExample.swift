//
//  GridExample.swift
//  Moonshot-8
//
//  Created by Mainul Dip on 1/4/24.
//

import SwiftUI

struct GridExample: View {
    
    let layout = [
        // signature -> GridItem( _ size: GridItem.Size = .flexible(), spacing: CGFloat? = nil, alignment: Alignment? = nil )
        GridItem(.fixed(80)),
        GridItem(.fixed(80)),
        GridItem(.fixed(80))
    ]
    
    let layoutAdaptive = [GridItem(.adaptive(minimum: 80))]
    
    let layoutFlexible = [GridItem(.flexible(minimum: 200, maximum: 300))]
    
    var body: some View {
        
        
        VStack {
            VStack {
                ScrollView {
                    // Vertical Lazy Grid For Vertical ScrollView
                    LazyVGrid(columns: layout) {
                        ForEach(0..<1000) {
                            Text("Item \($0)")
                        }
                    }
                }
            }
            
            Spacer(minLength: 20)
            
            VStack {
                ScrollView {
                    LazyVGrid(columns: layoutAdaptive) {
                        ForEach(0..<1000) {
                            Text("Item \($0)")
                        }
                    }
                }
            }
            
            Spacer(minLength: 20)
            
            VStack {
                // Showign Horizontal Lazy Grid on Horizontal ScrollView
                ScrollView (.horizontal) {
                    LazyHGrid(rows: layoutFlexible) {
                        ForEach(0..<1000) {
                            Text("Item \($0)")
                                .font(.largeTitle)
                        }
                    }
                }
            }
        }
    }
}

#Preview {
    GridExample()
}
