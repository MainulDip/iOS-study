//
//  DesignTokens.swift
//  Basic-Design-System-Impl
//
//  Created by Mainul Dip on 9/6/25.
//


import SwiftUI

public struct DesignTokens {
    public let colors: DSColors.Type = DSColors.self
    public let typography: DSTypography.Type = DSTypography.self
    public let spacing: DSSpacing.Type = DSSpacing.self
}


// Environment keys for accessing design tokens
private struct DesignTokensKey: EnvironmentKey {
    static let defaultValue = DesignTokens()
}

public extension EnvironmentValues {
    var designTokens: DesignTokens {
        get { self[DesignTokensKey.self] }
        set { self[DesignTokensKey.self] = newValue }
    }
}
