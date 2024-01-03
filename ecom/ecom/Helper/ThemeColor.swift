//
//  ThemeColor.swift
//  ecom
//
//  Created by Kosuru Uday Saikumar on 29/12/23.
//

import UIKit

protocol ThemeServiceInterface {
    func setThemeStyle(_ themeStyle: ThemeStyle)
    func getThemeStyle() -> ThemeStyle
}

final class ThemeColor: ThemeServiceInterface {

    static let shared = ThemeColor()

    let userDefaults: UserDefaults

    private init() {
        self.userDefaults = UserDefaults.standard
    }

    func setThemeStyle(_ themeStyle: ThemeStyle) {
        userDefaults.set(themeStyle.rawValue, forKey: PreferenceKeys.themeStyle)
    }

    func getThemeStyle() -> ThemeStyle {
        let rawValue = userDefaults.integer(forKey: PreferenceKeys.themeStyle)
        if let themeStyle = ThemeStyle(rawValue: rawValue) {
            return themeStyle
        }
        return .themeA
    }
}

struct PreferenceKeys {
    static let themeStyle = "theme_style"
    static let loginMessageColor = "#1D1E20"
    static let loginSubMessageColor = "#8F959E"
    static let mobileUnderLineColor = "#E7E8EA"
    static let otpTextColor = "#044236"
    static let agreeColor = "#2C6ECB"
    
    // MARK: - OTP View
    static let otpHeader = "#1C1C1C"
    static let validOTP = "#E7E8EA"
    static let invalidOTP = "#AA2823"
    static let resendText = "#044236"
}

enum ThemeStyle: Int {
    case themeA = 0
    case themeB
    case themeC
    case themeD
    case themeE
}

extension UIColor {

    static var primaryColor: UIColor {
        switch ThemeColor.shared.getThemeStyle() {
        case .themeA: return .systemBlue
        case .themeB: return .systemRed
        case .themeC: return .systemGreen
        case .themeD: return .systemIndigo
        case .themeE: return .white
        }
    }

    static var secondaryColor: UIColor {
        .systemPink
    }

    // ...
}


extension UIColor {
    convenience init(fromHex hex: String) {
        var hexSanitized = hex.trimmingCharacters(in: .whitespacesAndNewlines)
        hexSanitized = hexSanitized.replacingOccurrences(of: "#", with: "")

        var rgbValue: UInt64 = 0
        Scanner(string: hexSanitized).scanHexInt64(&rgbValue)

        let red = CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0
        let green = CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0
        let blue = CGFloat(rgbValue & 0x0000FF) / 255.0

        self.init(red: red, green: green, blue: blue, alpha: 1.0)
    }
}

