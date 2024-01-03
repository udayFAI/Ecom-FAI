//
//  Double+Extension.swift
//  ecom
//
//  Created by Kosuru Uday Saikumar on 02/01/24.
//

import UIKit

class Double_Extension: NSObject {

}

extension Double {
    func toPercentageOfScreenWidth() -> Double {
        let screenWidth = UIScreen.main.bounds.width
        return (self / screenWidth) * 100
    }

    func toPercentageOfScreenHeight() -> Double {
        let screenHeight = UIScreen.main.bounds.height
        return (self / screenHeight) * 100
    }
}
