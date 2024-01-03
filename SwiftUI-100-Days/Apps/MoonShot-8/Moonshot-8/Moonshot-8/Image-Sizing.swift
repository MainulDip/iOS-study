//
//  Image-Sizing.swift
//  Moonshot-8
//
//  Created by Mainul Dip on 1/3/24.
//

import SwiftUI

struct Image_Sizing: View {
    var body: some View {
        ZStack {
            // let img = ImageResource.imgStreetFighter6
            // any image placed inside Assets.xcassets folder can be accessable with ImageResource.imageName
            Image(.imgStreetFighter6)
                .resizable()
//                .imageScale(.large)
                .scaledToFill()
//                .scaledToFit()
//                .frame(width: 300, height: 300)
                .containerRelativeFrame(.horizontal) { size, axis in
                    size * 0.9 // setting image frame size to container's (ZStack) 90%
                }
                .clipped() // this do the actual cropping of the specified size above
                
            Text("Hello, world!")
        }
        .padding()
//        .ignoresSafeArea()
    }
}

#Preview {
    Image_Sizing()
}
