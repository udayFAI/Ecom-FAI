//
//  FooterView.swift
//  ecom
//
//  Created by Kosuru Uday Saikumar on 02/01/24.
//

import UIKit

@objc protocol sendOTPDelegate: AnyObject {
    @objc func sendotp()
}
class FooterView: UIView {

    @IBOutlet weak var otpButton: UIButton!
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
    
    var button: UIButton {
        return otpButton
    }
    
    var text: String {
        return otpButton.titleLabel?.text ?? "abcd"
    }
    
    weak var otpDelegate: sendOTPDelegate?
    // MARK: - Initializer
    override init(frame: CGRect) {
      super.init(frame: frame)
      self.loadFromNib()
    }
    
    required init?(coder aDecoder: NSCoder) {
      super.init(coder: aDecoder)
      self.loadFromNib()
    }
    
    func loadFromNib() {
      if let contentView = Bundle.main.loadNibNamed("FooterView", owner: self, options: nil)?.first as? UIView {
        contentView.frame = bounds
        addSubview(contentView)
          otpButton.corner(radius: 15.0)
          addDropShadow(color: .placeholderText, opacity: 0.5, offset: .zero, radius: 10.0, cornerRadius: 30.0)
          roundTopCorners(radius: 30.0, corner: [.layerMinXMinYCorner, .layerMaxXMinYCorner])
         
      }
    }
    
    @IBAction func otpHandler(_ sender: Any) {
        otpDelegate?.sendotp()
    }
}
