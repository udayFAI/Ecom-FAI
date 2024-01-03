//
//  View+Extension.swift
//  ecom
//
//  Created by Kosuru Uday Saikumar on 02/01/24.
//

import UIKit

class View_Extension: NSObject {

}
extension UIView {
    func addBorderAndColor(color: UIColor, width: CGFloat, corner_radius: CGFloat = 0, clipsToBounds: Bool = false) {
        self.layer.borderWidth  = width
        self.layer.borderColor  = color.cgColor
        self.layer.cornerRadius = corner_radius
        self.clipsToBounds      = clipsToBounds
    }
    
    func addBorderAndColor(color: String, width: CGFloat, corner_radius: CGFloat = 0, clipsToBounds: Bool = false) {
        self.layer.borderWidth  = width
        self.layer.borderColor  = UIColor(fromHex: color).cgColor
        self.layer.cornerRadius = corner_radius
        self.clipsToBounds      = clipsToBounds
    }
    
    func corner(radius: CGFloat = 25) {
      self.layer.cornerRadius = radius
      self.layer.masksToBounds = true
    }
}

extension UIView {

    // Adds a basic drop shadow to the view.
    func addDropShadow(color: UIColor = .black, opacity: Float = 0.5, offset: CGSize = CGSize(width: 0, height: 2), radius: CGFloat = 4, cornerRadius: CGFloat) {
        layer.masksToBounds = true
        layer.shadowColor = color.cgColor
        layer.shadowOpacity = opacity
        layer.shadowOffset = offset
        layer.shadowRadius = radius
        layer.cornerRadius = cornerRadius
    }

    // Configures the view's shadow properties using a dedicated shadow object.
    func setShadow(shadow: Shadow) {
        layer.masksToBounds = !shadow.clipsToBounds
        layer.shadowColor = shadow.color.cgColor
        layer.shadowOpacity = shadow.opacity
        layer.shadowOffset = shadow.offset
        layer.shadowRadius = shadow.radius
    }

    // Removes any existing shadow on the view.
    func removeShadow() {
        layer.masksToBounds = true
        layer.shadowColor = nil
        layer.shadowOpacity = 0
        layer.shadowOffset = .zero
        layer.shadowRadius = 0
    }
}

// A dedicated struct for defining shadow properties.
struct Shadow {
    let color: UIColor
    let opacity: Float
    let offset: CGSize
    let radius: CGFloat
    let clipsToBounds: Bool

    init(color: UIColor = .black, opacity: Float = 0.5, offset: CGSize = CGSize(width: 0, height: 2), radius: CGFloat = 4, clipsToBounds: Bool = true) {
        self.color = color
        self.opacity = opacity
        self.offset = offset
        self.radius = radius
        self.clipsToBounds = clipsToBounds
    }
}

extension UIView {
    func roundTopCorners(radius: CGFloat, withShadow shadow: Shadow? = nil, corner: CACornerMask) {
        layer.cornerRadius = radius
        layer.maskedCorners = corner // Top-left and top-right corners
        if let shadow = shadow {
            layer.masksToBounds = false // Allow shadow to appear
            setShadow(shadow: shadow)
        }
    }
}
