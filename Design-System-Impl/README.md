### Implementing Design System (UI Tokens) into ios Projects:
Tokens are the mapped variables of Colors, Fonts, Spacing values used in a Design System.

### Project Organization:
- Swift Packages (recommended for reusability)
- In-App organization | for simple app, organizing files in folders
- Assets.xcassets for colors (automatic dark mode)
- Environment-based access pattern

### Common Color Tokens:
Use semantic names (primary, secondary, accent, surface etc) instead of color names (blue, red-700, etc).

Use asset catalog to get automatic `light` and `dark` mode support.

```swift
public struct DSColors {
    // Semantic colors - what they mean, not what they look like
    public static let primary = Color("Primary", bundle: .module)
    public static let secondary = Color("Secondary", bundle: .module)
    public static let accent = Color("Accent", bundle: .module)

    // System colors - for different states and contexts
    public static let success = Color("Success", bundle: .module)
    public static let warning = Color("Warning", bundle: .module)
    public static let error = Color("Error", bundle: .module)

    // Surface colors - for background and containers
    public static let background = Color("Background", bundle: .module)
    public static let surface = Color("Surface", bundle: .module)
    public static let surfaceVariant = Color("SurfaceVariant", bundle: .module)

    // Text colors - readable on different background
    public static let onPrimary = Color("OnPrimary", bundle: .module)
    public static let onSurface = Color("OnSurface", bundle: .module)
    public static let onSurfaceSecondary = Color("OnSurfaceSecondary", bundle: .module)
}
```

### Common Font/Typography Tokens:
SwiftUI provide `dynamic` typography, which can be used with built in fonts

```swift
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

    // Label styles - for UI elements
    public static let labelLarge = Font.callout.weight(.medium)
    public static let labelMedium = Font.caption.weight(.medium)
    public static let labelSmall = Font.caption2.weight(.medium)
}
```

### Common Spacing Tokens:
Spacing should be consistent and based on a base unit

```swift
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
}
```


### Constants vs Environment variables:
Environment variables are context aware. So Instead of a large file containing all Design Tokens as constants, utilizing Environment variable will provide context aware (light/dark mode) results.

```swift
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

struct SomeView: View {
    @Environment(\.designTokens) private var tokens

    var body: some View {
        Text("Hello, Design System")
            .font(tokens.typography.headlineMedium)
            .foregroundColor(token.colors.onSurface)
            .padding(tokens.spacing.md)
    }
}
```

### Core Components for Material Design 3:
Components are interactive building blocks for creating a user interface.

- Buttons
    - Button groups
    - Regular Buttons
    - Regular, Extended FAB, FAB Menu (Floating Action Button)
    - Icon Buttons
    - Segmented buttons
    - Split buttons
- Pickers: Date pickers, Time pickers
- Indicators: Loading indicator, Progress indicators
- Navigation: Navigation bar, Navigation drawer, Navigation rail
- Sheets: Bottom sheets, Side sheets
- App bars
- Badges
- Cards
- Carousel
- Checkbox
- Chips
- Dialogs
- Divider
- Lists
- Menus
- Radio buttons
- Search
- Sliders
- snackbar
- Switch
- Tabs
- Text fields
- Toolbars
- Tooltips


Docs: https://m3.material.io/components

### ios System/Core components:
- Content
    - Charts, Image views, Text view, Web views
- Layout and organization
    - Boxes
    - collections
    - Column  views
    - Disclosure controls
    - Labels
    - Lists and tables
    - Lockups
    - Outline views
    - Split views
    - Tab views
- Menus and actions
    - Activity views / share sheet (UIKit)
    - Buttons
    - Context menus
    - Dock menus
    - Edit menus
    - Home Screen quick actions
    - Menus
    - Ornaments
    - Pop-up buttons
    - Pull-down buttons
    - The menu bar
    - Toolbars
- Navigation and search
    - Path controls
    - Search fields
    - Sidebars
    - Tab bars
    - Token fields
- Presentation
    - Actions sheets
    - Alerts
    - Page controls
    - Panels
    - Popovers
    - Scroll views
    - Sheets
    - Windows
- Section and input
    - color wells
    - Combo boxes
    - Digit entry views
    - Image wells (editable version of an image view)
    - Pickers
    - Segmented controls
    - sliders
    - Steppers
    - Text fields
    - Toggles
    - Virtual keyboards
- Status
    - Activity rings
    - Gauges
    - Progress indicators 
    - Rating indicators
- System experiences
    - App Shortcuts
    - complications
    - Controls
    - Live Activities
    - Notifications
    - Status bars
    - Top Shelf
    - Watch faces
    - Widgets

Docs: https://developer.apple.com/design/human-interface-guidelines/components

### Building Custom Components using Enumeration:
All custom components should follow the same structure.


```swift
// Defining custom button
public struct DSButtons: View {
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

    var body: some View {
    Button(action: {
      print("\(title) button was tapped")
    }) {
      Text(text)
        .foregroundColor(.white)
        .padding()
        .background(Color.blue)
        .cornerRadius(10)
    }
  }
}

// Styling Logics
private extension DSButton {
    var fontForSize: Font {
        switch size {
            case .small return DSTypography.labelMedium
            case .medium return DSTypography.labelLarge
            case .large return DSTypography.bodyLarge
        }
    }

    var fontWeightForStyle: Font.Weight {
        switch style {
            case .primary, .destructive: return .semibold
            case .secondary, .ghost: return .medium
        }
    }

    var foregroundColor: Color {
        switch style {
            case .primary: return DSColors.onPrimary
            case .secondary: return DSColors.primary
            case .destruction: return DSColors.onPrimary
            case .ghost: return DSColors.primary
        }
    }

    var backgroundColor: Color {
        switch style {
            case .primary: return DSColors.primary 
            case .secondary: return DSColors.surface
            case .destruction: return DSColors.error
            case .ghost: return DSColors.clear
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
            case .small: return 6
            case .medium: return 8
            case .large: return 12
        }
    }
}

// usages
public var body: some View {
    Button()
}
```
- SwiftUI building custom component (Button)