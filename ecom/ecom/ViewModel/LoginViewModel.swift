//
//  LoginViewModel.swift
//  ecom
//
//  Created by Kosuru Uday Saikumar on 02/01/24.
//

import UIKit

class LoginViewModel: NSObject {
    var validate: Validate =  Validate()

    func textFieldCharactersValidate(text: String) -> Bool {
        return validate.isDigitsAcceptDeleteBackSpace(text: text, maxLength: 10)
    }
}
