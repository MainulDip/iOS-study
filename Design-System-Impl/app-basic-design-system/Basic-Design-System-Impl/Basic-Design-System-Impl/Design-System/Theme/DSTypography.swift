//
//  DSTypography.swift
//  Basic-Design-System-Impl
//
//  Created by Mainul Dip on 9/4/25.
//

import Foundation
import SwiftUI

public struct DSTypography {
    // Display styles - for heroes and big statements
    public static let displayLarge = Font.largeTitle.weight(.bold)
    public static let displayMedium = Font.title.weight(.bold)
    public static let displaySmall = Font.title2.weight(.bold)

    // Headline styles - for section headers
    public static let headlineLarge = Font.title2.weight(.semibold)
    public static let headlineMedium = Font.title3.weight(.semibold)
    public static let headlineSmall = Font.headline.weight(.semibold)

    // Body styles - for main content
    public static let bodyLarge = Font.body
    public static let bodyMedium = Font.callout
    public static let bodySmall = Font.caption

    // Label styles - for UI elements - Buttons
    public static let labelLarge = Font.callout.weight(.medium)
    public static let labelMedium = Font.caption.weight(.medium)
    public static let labelSmall = Font.caption2.weight(.medium)
}
