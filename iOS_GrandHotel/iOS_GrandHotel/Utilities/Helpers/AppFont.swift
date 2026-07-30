
import SwiftUI

// MARK: - Font Weight

enum FontWeight: String {
    case bold = "Bold"
    case regular = "Regular"
    case medium = "Medium"
    case semiBold = "SemiBold"
    
    var suffix: String {
        rawValue
    }
}


// MARK: - Font Helper

enum FontHelper {
    
    private static let fontFamily = "Jost"
    
    static func font(
        size: CGFloat,
        weight: FontWeight
    ) -> Font {
        Font.custom(
            "\(fontFamily)-\(weight.suffix)",
            size: size
        )
    }
}


// MARK: - Text Style Modifier

struct TextStyleModifier: ViewModifier {
    
    let size: CGFloat
    let weight: FontWeight
    let color: Color
    
    func body(content: Content) -> some View {
        content
            .font(
                FontHelper.font(
                    size: size,
                    weight: weight
                )
            )
            .foregroundStyle(color)
    }
}


// MARK: - View Extension

extension View {
    
    func textStyle(
        size: CGFloat = 16,
        weight: FontWeight = .regular,
        color: Color = .primary
    ) -> some View {
        
        self.modifier(
            TextStyleModifier(
                size: size,
                weight: weight,
                color: color
            )
        )
    }
}
