//
//  NavMessageView.swift
//  ecom
//
//  Created by Kosuru Uday Saikumar on 29/12/23.
//

import UIKit

class NavMessageView: UIView {

    @IBOutlet weak var headerLabel: UILabel!
    
    @IBOutlet weak var bodyLabel: UILabel!
    
    @IBOutlet weak var subBodyLabel: UILabel!
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
    
    var text: String? {
      return headerLabel.text
    }
    
    var text1: String? {
        return bodyLabel.text
    }
    
    var text2: String? {
        return subBodyLabel.text
    }
    
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
      if let contentView = Bundle.main.loadNibNamed("NavMessageView", owner: self, options: nil)?.first as? UIView {
        contentView.frame = bounds
        addSubview(contentView)
      }
    }
}

