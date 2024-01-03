//
//  ViewController.swift
//  ecom
//
//  Created by Kosuru Uday Saikumar on 29/12/23.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var headerView: NavMessageView!
    @IBOutlet weak var gap1HeightLayout: NSLayoutConstraint!
    @IBOutlet weak var mobileMessageLabel: UILabel!
    @IBOutlet weak var mobileUnderlineView: UIView!
    @IBOutlet weak var mobileNumberTextField: UITextField!
    @IBOutlet weak var mobileStatusImage: UIImageView!
    @IBOutlet weak var otpview: FooterView!
    
    @IBOutlet weak var agreeGapLayout: NSLayoutConstraint!
    @IBOutlet weak var agreeCheckBox: UIButton!
    @IBOutlet weak var agreeLabel: ABTappableLabel!
    var viewModel = LoginViewModel()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Auto layout, variables, and unit scale are not yet supported
        // Do any additional setup after loading the view.
        setupUI()
        
        setDelegateUI()
    }


    func setupUI() {
        headerView.headerLabel.text = "Login"
        headerView.headerLabel.font = .customFont(Inter.bold, forTextStyle: .headline)
        headerView.headerLabel.textColor = UIColor(named: PreferenceKeys.loginMessageColor)
        
        headerView.bodyLabel.text = "Please enter your mobile number"
        headerView.bodyLabel.font = .customFont(Inter.regular, forTextStyle: .subheadline)
        headerView.bodyLabel.textColor = UIColor(fromHex: PreferenceKeys.loginSubMessageColor)
        
        headerView.subBodyLabel.isHidden = true
        
        gap1HeightLayout.constant = 51.toPercentageOfScreenWidth()
        agreeGapLayout.constant = 20
        
        mobileUnderlineView.backgroundColor = UIColor(fromHex: PreferenceKeys.mobileUnderLineColor)
        
        mobileMessageLabel.textColor = UIColor(fromHex: PreferenceKeys.loginSubMessageColor)
        mobileMessageLabel.font = .customFont(Inter.regular, forTextStyle: .subheadline)
        
        mobileStatusImage.image = nil
        otpview.button.backgroundColor = UIColor(fromHex: PreferenceKeys.otpTextColor)
        otpview.button.tintColor = .white
        otpview.otpButton.setTitle("Send OTP", for: .normal)
        agreeLabel.textColor = UIColor(fromHex: PreferenceKeys.loginSubMessageColor)
        agreeLabel.font = .customFont(Inter.regular, forTextStyle: .subheadline)
        agreeLabel.text = Constant.agree
        agreeCheckBox.addBorderAndColor(color: PreferenceKeys.agreeColor, width: 1.0, corner_radius: 3.0, clipsToBounds: true)

        agreeLabel = agreeLabel.makeTappable(string: "Term and Condition", hyperlinkeAttributes: [.underlineColor: UIColor.black, .foregroundColor: UIColor(fromHex: PreferenceKeys.loginMessageColor), .underlineStyle : 1.0], tapHandler: {
            print("Term and conditions")
        })
    }
    
    func setDelegateUI() {
        mobileNumberTextField.delegate = self
        mobileNumberTextField.keyboardType = .numberPad
        otpview.otpDelegate = self
    }
    
    func mobileNumberEmpty() -> Bool {
        return mobileNumberTextField.text?.isEmpty ?? true
    }
    
    @IBAction func agreeHandler(_ sender: UIButton) {
        sender.isSelected.toggle()
    }
}

extension ViewController: UITextFieldDelegate {
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        if let text = mobileNumberTextField.text, viewModel.validate.numberValidation(text: text), viewModel.validate.mobileNumberCount(text: text), viewModel.validate.isValidMobileNumber(text: text) {
            mobileMessageLabel.text = "Enter mobile number "
            mobileStatusImage.image = UIImage(named: "mobileSuccess")
            mobileMessageLabel.textColor = UIColor(fromHex: PreferenceKeys.loginSubMessageColor)
            mobileMessageLabel.font = .customFont(Inter.regular, forTextStyle: .subheadline)
            mobileUnderlineView.backgroundColor = UIColor(fromHex: PreferenceKeys.mobileUnderLineColor)
            
        } else if let age = mobileNumberTextField.text, age.count <= 0 {
            mobileMessageLabel.text = ""
            mobileMessageLabel.textColor = .red
            mobileUnderlineView.backgroundColor = .red
            mobileStatusImage.image = nil
        } else {
            mobileMessageLabel.text = "Enter mobile number "
            mobileMessageLabel.textColor = .red
            mobileStatusImage.image =  nil
            mobileUnderlineView.backgroundColor = .red
        }
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let currentText = textField.text ?? ""
        let newText = (currentText as NSString).replacingCharacters(in: range, with: string)
        if newText.isEmpty {
            mobileMessageLabel.text = ""
            mobileStatusImage.image = nil
        }
        return viewModel.textFieldCharactersValidate(text: newText)
    }
}

extension ViewController: sendOTPDelegate {
    func sendotp() {
        if mobileNumberEmpty() {
           AlertHelper.showAlert(title: "eCom", message: "Mobile number is missing", viewController: self)
        } else {
            showOTPVC()
        }
    }
}
