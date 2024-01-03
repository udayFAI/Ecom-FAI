//
//  Validate.swift
//  ecom
//
//  Created by Kosuru Uday Saikumar on 02/01/24.
//

import UIKit

class Validate: NSObject {
    
    // MARK: - Mobile number validate
    func numberValidation(text: String) -> Bool {
        return text.rangeOfCharacter(from: CharacterSet.decimalDigits.inverted) == nil
    }
    func mobileNumberCount(text: String) -> Bool {
        return text.count >= 10
    }
    func isValidMobileNumber(text: String) -> Bool {
        let mobileNumberRegex = Regex.mobileNumber
        let predicate = NSPredicate(format: "SELF MATCHES %@", mobileNumberRegex)
        return predicate.evaluate(with: text)
    }
 
    func isDigitsAcceptDeleteBackSpace(text: String, maxLength : Int = 3) -> Bool {
        let allowedCharacters = CharacterSet.decimalDigits
        let characterSet = CharacterSet(charactersIn: text)
        return allowedCharacters.isSuperset(of: characterSet) && text.count <= maxLength
    }
}
