import SwiftUI

#if os(iOS)
import UIKit
#endif


// MARK: - Font Weight

enum FontWeight: String {
    case bold = "Bold"
    case regular = "Regular"
    case medium = "Medium"
    
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
    
    #if os(iOS)
    static func uiFont(
        size: CGFloat,
        weight: FontWeight
    ) -> UIFont {
        UIFont(
            name: "\(fontFamily)-\(weight.suffix)",
            size: size
        ) ?? UIFont.systemFont(
            ofSize: size,
            weight: weight.uiWeight
        )
    }
    #endif
}


// MARK: - UIKit Font Weight Mapping

#if os(iOS)
extension FontWeight {
    
    var uiWeight: UIFont.Weight {
        switch self {
        case .bold:
            return .bold
        case .regular:
            return .regular
        case .medium:
            return .medium
        }
    }
}
#endif


// MARK: - App Fonts

enum AppFont {
    
    static let splashTitle = FontHelper.font(
        size: 40,
        weight: .bold
    )
    
    static let splashSubTitle = FontHelper.font(
        size: 14,
        weight: .regular
    )
}
