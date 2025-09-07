//
//  DSSpacing.swift
//  Basic-Design-System-Impl
//
//  Created by Mainul Dip on 9/4/25.
//

import Foundation

public struct DSSpacing {
    // Base unit, everything derives from it
    private static let baseUnit: CGFloat = 4

    // Spacing scale - powers of our base unit
    public static let xs = baseUnit * 1 // 4pt
    public static let sm = baseUnit * 2 // 4pt
    public static let md = baseUnit * 4 // 4pt
    public static let lg = baseUnit * 6 // 4pt
    public static let xl = baseUnit * 8 // 4pt
    public static let xxl = baseUnit * 12 // 4pt
    public static let xxxl = baseUnit * 16 // 4pt

    // Semantic spacing - for specific use cases
    public static let buttonPadding = md
    public static let cardPadding = lg
    public static let sectionSpacing = xl
    public static let screenPadding = md
    
    // Radius
    public static let radiusXs: CGFloat = xs
    public static let radiusSm: CGFloat = sm
    public static let radiusMd: CGFloat = md
    public static let radiuslg: CGFloat = lg
}
