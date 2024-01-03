//
//  OTPViewController.swift
//  ecom
//
//  Created by Kosuru Uday Saikumar on 02/01/24.
//

import UIKit

class OTPViewController: UIViewController {

    @IBOutlet weak var navHeaderView: NavHeaderView!
    @IBOutlet weak var otpField: OTPFieldView!
    @IBOutlet weak var messageView: NavMessageView!
    
    @IBOutlet weak var footerView: FooterView!
    @IBOutlet weak var errorMessage: UILabel!
    @IBOutlet weak var timerTextMessage: ABTappableLabel!
    
    @IBOutlet weak var resendUnderlineView: UIView!
    @IBOutlet weak var resendTextLabel: UILabel!
    private var otp: String = ""
    var phone: String = "8465969964"
  
    @IBOutlet weak var otpview: OTPView!
    
    
    var otpModel: OTPViewModel = OTPViewModel()
    
    deinit {
        otpModel.stopTimer()
        stopTimerUI()
    }
    var isStatus: Bool = false
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupOtpView()
        setDelegateUI()
//        setupOTP()
        NotificationCenter.default.addObserver(self, selector: #selector(appBecomeActiveObserver), name:UIApplication.willEnterForegroundNotification, object: nil)
        otpModel.timer = Timer()
        resendTextLabel.alpha = 0
        resendUnderlineView.alpha = 0
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(handleLabelTap))
        resendTextLabel.addGestureRecognizer(tapGestureRecognizer)
        
        // Do any additional setup after loading the view.
    }
    
    @objc func handleLabelTap() {
        // Your action when the label is tapped
        print("Label tapped!")
        otpModel.startTimer()
        otpModel.timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(self.updateTimer), userInfo: nil, repeats: true)
        timerTextMessage.text = otpModel.timeFormatted(otpModel.timercount) + " sec to resend confirmation code"
    }
    
    func timerMessageHandler() {
        timerTextMessage = timerTextMessage.makeTappable(string: "sec to resend confirmation code", hyperlinkeAttributes: [.foregroundColor: UIColor(fromHex: PreferenceKeys.loginSubMessageColor)], tapHandler: {
            print("resend message")
        })
    }
    
    override func viewWillAppear(_ animated: Bool) {
        otpModel.startTimer()
        otpModel.timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(self.updateTimer), userInfo: nil, repeats: true)
        timerTextMessage.text = otpModel.timeFormatted(otpModel.timercount) + " sec to resend confirmation code"
        timerMessageHandler()
    }
    
    @objc func updateTimer() {
        otpModel.timercount = otpModel.timercount - 1
        timerTextMessage.text = otpModel.timeFormatted(otpModel.timercount) + " sec to resend confirmation code"
        if otpModel.timercount <= 0 {
            otpModel.stopTimer()
            stopTimerUI()
        } else {
             timerMessageHandler()
        }
    }
    
    @objc func appBecomeActiveObserver(){
        otpModel.checkAndUpdateTimer()
    }
    
    func setupUI() {
        messageView.headerLabel.text = "Verification Code"
        messageView.headerLabel.font = .customFont(Inter.bold, forTextStyle: .headline)
        messageView.headerLabel.textColor = UIColor(named: PreferenceKeys.otpHeader)
        
        messageView.bodyLabel.text = "Enter 4 digit code received in"
        messageView.bodyLabel.font = .customFont(Inter.regular, forTextStyle: .subheadline)
        messageView.bodyLabel.textColor = UIColor(fromHex: PreferenceKeys.loginSubMessageColor)
        
        messageView.subBodyLabel.text = phone
        messageView.subBodyLabel.font = .customFont(Inter.regular, forTextStyle: .subheadline)
        messageView.subBodyLabel.textColor = UIColor(fromHex: PreferenceKeys.loginMessageColor)
        
        footerView.button.backgroundColor = UIColor(fromHex: PreferenceKeys.otpTextColor)
        footerView.button.tintColor = .white
        footerView.otpButton.setTitle("Confirm OTP", for: .normal)
        
        resendTextLabel.text = "Resend OTP"
        resendUnderlineView.backgroundColor = UIColor(fromHex: PreferenceKeys.loginMessageColor)
        resendTextLabel.textColor = UIColor(fromHex: PreferenceKeys.resendText)
        resendTextLabel.font = .customFont(Inter.medium, forTextStyle: .title1)
        
        navHeaderView.backDelegate = self
    }
    
    func setDelegateUI() {
       footerView.otpDelegate = self
    }
    
    func setupOtpView() {
        otpField.fieldsCount = 4
        otpField.fieldBorderWidth = 1
        otpField.defaultBorderColor = UIColor(fromHex: PreferenceKeys.validOTP)
        otpField.filledBorderColor = .white
        otpField.cursorColor = UIColor(fromHex: PreferenceKeys.loginMessageColor)
        otpField.errorBorderColor = UIColor(fromHex: PreferenceKeys.invalidOTP)
        otpField.filledBackgroundColor = .white
        otpField.defaultBackgroundColor = .white
        otpField.otpInputType = .numeric
        otpField.displayType = .square
        otpField.requireCursor = true
//        otpField.fieldSize = 70
        otpField.separatorSpace = 16
        otpField.shouldAllowIntermediateEditing = true
        otpField.delegate = self
        otpField.initializeUI()
    }
    
    func stopTimerUI() {
        timerTextMessage.text = otpModel.timeFormatted(otpModel.timercount) + " sec to resend confirmation code"
        resendTextLabel.alpha = 1
        resendUnderlineView.alpha = 1
        timerMessageHandler()
    }
//    func setupOTP() {
//        otpview.initializeOTPUI()
//        otpview.fieldsCount = 4
//        otpview.borderWidth = 2
//        otpview.emptyFieldBorderColor = UIColor(fromHex: PreferenceKeys.validOTP)
//        otpview.isSecureEntry = true
//        otpview.requireCursor = true
//        otpview.secureEntrySymbol = .none
//        otpview.errorBorderColor = UIColor(fromHex: PreferenceKeys.invalidOTP)
//        otpview.textColor = UIColor(fromHex: PreferenceKeys.loginMessageColor)
//        otpview.cursorColor = UIColor(fromHex: PreferenceKeys.loginMessageColor)
//        otpview.secureEntrySymbolColor = .white
//        otpview.enteredFieldBackgroundColor =  .white
//        otpview.placeholderColor = .white
//        otpview.otpFieldDisplayType = .box
//        otpview.delegate = self
//        otpview.isTextfieldBecomFirstResponder = true
//    }
}

extension OTPViewController: OTPFieldViewDelegate {
    func hasEnteredAllOTP(hasEnteredAll hasEntered: Bool) -> Bool {
        print("Has entered all OTP? \(hasEntered)")
        if otp == "1111" {
            errorMessage.textColor = UIColor(fromHex: PreferenceKeys.invalidOTP)
            errorMessage.text = "Incorrect OTP"
            messageView.bodyLabel.textColor = UIColor(fromHex: PreferenceKeys.loginSubMessageColor)
            isStatus = false
            return false
        } else {
            otpModel.stopTimer()
            stopTimerUI()
            errorMessage.textColor = .clear
            errorMessage.text = ""
            isStatus = true
            return true
        }
    }
    
    func shouldBecomeFirstResponderForOTP(otpTextFieldIndex index: Int) -> Bool {
        return true
    }
    
    func enteredOTP(otp otpString: String) {
        otp = otpString
        print("OTPString: \(otpString)")
    }
}

//extension OTPViewController: OTPViewDelegate {
//    func shouldBecomeFirstResponderForOTP(otpFieldIndex index: Int) -> Bool {
//        return true
//    }
//    
//    func hasEnteredAllOTP(hasEntered: Bool) -> Bool {
//        return true
//    }
//    
//    func enteredOTP(otpString: String) {
//        otp = otpString
//    }
//}

extension OTPViewController: sendOTPDelegate {
    func sendotp() {
        if isStatus {
            AlertHelper.showAlert(title: "Ecomm", message: "You have successfully logged in", viewController: self)
        } else {
            otpField.secureEntryData = ["1", "1", "1", "1"]
            otpField.calculateEnteredOTPSTring(isDeleted: false)
        }
    }
}

extension OTPViewController: isBackHandlerProtocol {
    func backHandler() {
        dismiss(animated: true)
    }
}
