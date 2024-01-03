//
//  NavHeaderView.swift
//  ecom
//
//  Created by Kosuru Uday Saikumar on 29/12/23.
//

import UIKit

@objc protocol isBackHandlerProtocol: AnyObject {
    @objc func backHandler()
}

class NavHeaderView: UIView {
    
    /*
     // Only override draw() if you perform custom drawing.
     // An empty implementation adversely affects performance during animation.
     override func draw(_ rect: CGRect) {
     // Drawing code
     }
     */
    
    weak var backDelegate: isBackHandlerProtocol?
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
        if let contentView = Bundle.main.loadNibNamed("NavHeaderView", owner: self, options: nil)?.first as? UIView {
            contentView.frame = bounds
            addSubview(contentView)
        }
    }
    
    @IBAction func backHandler(_ sender: Any) {
        backDelegate?.backHandler()
    }
}
