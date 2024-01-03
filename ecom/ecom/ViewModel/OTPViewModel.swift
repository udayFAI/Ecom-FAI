//
//  OTPViewModel.swift
//  ecom
//
//  Created by Kosuru Uday Saikumar on 03/01/24.
//

import UIKit

class OTPViewModel: NSObject {
    var timercount = OTP_MAX_SEC
    var timer:Timer!
    
     func checkAndUpdateTimer() {
        let otpStartedTime = AppUserDefaults.SharedInstance.otpInitiatedTimerValue
        let currentTime = Date().timeIntervalSince1970
        let difference = currentTime - otpStartedTime
        if Int(difference) >= OTP_MAX_SEC {
            self.timercount = 0
        } else {
            self.timercount = OTP_MAX_SEC - Int(difference)
        }
    }
    
    func startTimer() {
        stopTimer()
        timercount = OTP_MAX_SEC
        AppUserDefaults.SharedInstance.otpInitiatedTimerValue = Date().timeIntervalSince1970
    }
    
    func stopTimer() {
        if timer != nil {
            timer.invalidate()
            timer = nil
            self.timercount = 0
            AppUserDefaults.SharedInstance.otpInitiatedTimerValue = 0
        }
    }
    
    func timeFormatted(_ totalSeconds: Int) -> String {
        let seconds: Int = totalSeconds % 60
        let minutes: Int = (totalSeconds / 60) % 60
        //     let hours: Int = totalSeconds / 3600
        return String(format: "%02d:%02d", minutes, seconds)
    }
}
