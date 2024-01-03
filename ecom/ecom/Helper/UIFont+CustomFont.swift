//
//  UIFont+CustomFont.swift
//  ecom
//
//  Created by Kosuru Uday Saikumar on 29/12/23.
//

import UIKit

protocol DynamicFonts {
    func fontName() -> String
    func fontSize(style: UIFont.TextStyle) -> CGFloat
}

extension UIFont {

    class func customFont(
        _ font: DynamicFonts,
        forTextStyle style: UIFont.TextStyle,
        overrideFontSize: UIContentSizeCategory? = nil
    ) -> UIFont? {
//        print(".......... ", font.fontName())
//        print(",,,,,,, ", font.fontSize(style: style))
        guard let customFont = UIFont(name: font.fontName(), size: font.fontSize(style: style)) else { return nil }
        let scaledFont: UIFont
        let metrics = UIFontMetrics(forTextStyle: style)
        scaledFont = metrics.scaledFont(
            for: customFont, compatibleWith: UITraitCollection(
                preferredContentSizeCategory: overrideFontSize ?? .unspecified
            )
        )
        return scaledFont
    }
}

enum Inter: DynamicFonts {
    case black
    case bold
    case extraBold
    case extraLight
    case light
    case medium
    case regular
    case semiBold
    case thin
    
    func fontName() -> String {
        switch self {
        case .black: return "Inter-Black"
        case .bold: return "Inter-Bold"
        case .extraBold: return "Inter-ExtraBold"
        case .extraLight: return "Inter-ExtraLight"
        case .light: return "Inter-Light"
        case .medium: return "Inter-Medium"
        case .regular: return "Inter-Regular"
        case .semiBold: return "Inter-SemiBold"
        case .thin: return "Inter-Thin"
        }
    }

    // swiftlint:disable:next cyclomatic_complexity
    func fontSize(style: UIFont.TextStyle) -> CGFloat {
        switch style {
        case .headline: return 20.0
        case .subheadline: return 14.0
        case .title1: return 18.0
            
        case .largeTitle: return 34.0
        
        case .title2: return 22.0
        case .title3: return 20.0
        
        case .body: return 17.0
        case .callout: return 16.0
        
        case .footnote: return 13.0
        case .caption1: return 12.0
        case .caption2: return 11.0
        default: return 17.0
        }
    }
}
