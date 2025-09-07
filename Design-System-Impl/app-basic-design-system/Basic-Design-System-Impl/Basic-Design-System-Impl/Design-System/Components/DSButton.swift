//
//  DSButton.swift
//  Basic-Design-System-Impl
//
//  Created by Mainul Dip on 9/6/25.
//

import SwiftUI

public struct DSButton: View {
    
    public enum Style {
        case primary
        case secondary
        case destructive
        case ghost
    }
    
    public enum Size {
        case small
        case medium
        case large
    }
    
    private let title: String
    private let style: Style
    private let size: Size
    private let isLoading: Bool
    private let action: () -> Void
    
    public init(
        _ title: String,
        style: Style = .primary,
        size: Size = .medium,
        isLoading: Bool = false,
        action: @escaping () -> Void
    ) {
        self.title = title
        self.style = style
        self.size = size
        self.isLoading = isLoading
        self.action = action
    }
    
    public var body: some View {
        Button {
            action()
        } label: {
            Text(title)
                .font(fontForSize)
                .foregroundStyle(foregroundColorForStyle)
                .padding(paddingForSize)
        }
        .background(backgroundColorForStyle)
        .cornerRadius(cornerRadiusForSize)
    }
}

private extension DSButton {
    var fontForSize: Font {
        switch size {
        case .small: return DSTypography.labelSmall
        case .medium: return DSTypography.labelMedium
        case .large: return DSTypography.labelLarge
        }
    }
    
    var fontWeightForStyle: Font.Weight {
        switch style {
        case .primary, .destructive: return .semibold
        case .secondary, .ghost: return .medium
        }
    }
    
    var foregroundColorForStyle: Color {
        switch style {
        case .primary: return DSColors.onPrimary
        case .secondary: return DSColors.onSedondary
        case .destructive: return DSColors.onError
        case .ghost: return DSColors.onSurface
        }
    }
    
    var backgroundColorForStyle: Color {
        switch style {
        case .primary: return DSColors.primary
        case .secondary: return DSColors.sedondary
        case .destructive: return DSColors.error
        case .ghost: return DSColors.surface
        }
    }
    
    var paddingForSize: EdgeInsets {
        switch size {
            case .small: return EdgeInsets(top: DSSpacing.sm, leading: DSSpacing.md, bottom: DSSpacing.sm, trailing: DSSpacing.md)
            case .medium: return EdgeInsets(top: DSSpacing.md, leading: DSSpacing.lg, bottom: DSSpacing.md, trailing: DSSpacing.lg)
            case .large: return EdgeInsets(top: DSSpacing.lg, leading: DSSpacing.xl, bottom: DSSpacing.lg, trailing: DSSpacing.xl)
        }
    }
    
    var cornerRadiusForSize: CGFloat {
        switch size {
            case .small: return DSSpacing.sm
            case .medium: return DSSpacing.md
            case .large: return DSSpacing.lg
        }
    }
}


#Preview {
    DSButton("Fist Button Enum") {
        
    }
}
