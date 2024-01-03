//
//  AppUserDefaults.swift
//  ecom
//
//  Created by Kosuru Uday Saikumar on 02/01/24.
//

import UIKit
import Foundation

class AppUserDefaults: NSObject  {
    // MARK:- Instances Variables
    static let  SharedInstance = AppUserDefaults()
    let userdefaults = UserDefaults.standard
    var otpInitiatedTimerValue: Double = 0
    
    var isDarkmodel: Bool {
           get {
               return userdefaults.bool(forKey: "isDarkMode")
           } set(isDemo) {
               userdefaults.set(isDemo, forKey: "isDarkMode")
               userdefaults.synchronize()
           }
       }
    
    var languageCode: String {
        get {
            if let languageCode = userdefaults.value(forKey: "APP_LANGUAGE_CODE") as? String {
                return languageCode
            } else {
                return "en"
            }
        } set(languageCode) {
            userdefaults.set(languageCode, forKey: "APP_LANGUAGE_CODE")
            userdefaults.synchronize()
        }
        
        
    }
   
    var access_token: String {
        get {
            if let access_token = userdefaults.value(forKey: "access_token") as? String {
                return access_token
            } else {
                return ""
            }
        } set(access_token) {
            userdefaults.set(access_token, forKey: "access_token")
            userdefaults.synchronize()
        }
    }
    
    
    func reset()  {
        self.access_token = ""
        self.otpInitiatedTimerValue = 0
    }
}
