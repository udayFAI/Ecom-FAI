//
//  ABTappableLabel.swift
//  ecom
//
//  Created by Kosuru Uday Saikumar on 02/01/24.
//

import UIKit
import Foundation

typealias ABLabelTapHandler = (() -> Void)

class ABTappableLabel: UILabel {
    
    private var tapHandlerDetails: [String: ABLabelTapHandler] = [:]
    
    //MARK: - Initialiizer methods
    
    init(text: String) {
        super.init(frame: CGRect.zero)
        self.text = text
        setup()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setup()
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setup()
    }
    
    //MARK: - Private methods
    
    private func setup() {
        self.isUserInteractionEnabled = true
    }
    
    @objc fileprivate func tappedOnLabel(_ gesture: RangeGestureRecognizer) {
        guard let text = self.text else { return }
        for (key, value) in tapHandlerDetails {
            let stringRange = (text as NSString).range(of: key)
            if gesture.didTapAttributedTextInLabel(label: self, inRange: stringRange) {
                value()
            }
        }
    }
        
    //MARK: - Public methods
    
    func makeTappable(string: String,
                      hyperlinkeAttributes: [NSAttributedString.Key: Any] = NSAttributedString.linkAppearanceAttributes,
                      tapHandler: @escaping ABLabelTapHandler) -> Self {
        
        //setup gesture recognizer
        var tapGesture: RangeGestureRecognizer
        if let rangeRapGesture = gestureRecognizers?.first as? RangeGestureRecognizer {
            tapGesture = rangeRapGesture
        } else {
            tapGesture = RangeGestureRecognizer(target: self, action: #selector(tappedOnLabel(_ :)))
            tapGesture.numberOfTapsRequired = 1
            self.addGestureRecognizer(tapGesture)
        }
                
        //Add appearance
        var attributedString: NSMutableAttributedString!
        if let attributedText = self.attributedText {
            attributedString = NSMutableAttributedString(attributedString: attributedText)
        } else if let normalText = self.text {
            attributedString = NSMutableAttributedString(string: normalText)
        }
        if let range = attributedString.string.ranges(of: string).first {
            attributedString.addAttributes(hyperlinkeAttributes, range: range)
        }
        self.attributedText = attributedString
        
        tapHandlerDetails[string] = tapHandler

        return self
    }
   
}

fileprivate extension ABTappableLabel {
    
    class RangeGestureRecognizer: UITapGestureRecognizer {
              
        func didTapAttributedTextInLabel(label: UILabel, inRange targetRange: NSRange) -> Bool {
            // Create instances of NSLayoutManager, NSTextContainer and NSTextStorage
            let layoutManager = NSLayoutManager()
            let textContainer = NSTextContainer(size: CGSize.zero)
            let textStorage = NSTextStorage(attributedString: label.attributedText!)
          
            // Configure layoutManager and textStorage
            layoutManager.addTextContainer(textContainer)
            textStorage.addLayoutManager(layoutManager)
          
            // Configure textContainer
            textContainer.lineFragmentPadding = 0.0
            textContainer.lineBreakMode = label.lineBreakMode
            textContainer.maximumNumberOfLines = label.numberOfLines
            let labelSize = label.bounds.size
            textContainer.size = labelSize
            
            // Find the tapped character location and compare it to the specified range
            let locationOfTouchInLabel = self.location(in: label)
            let textBoundingBox = layoutManager.usedRect(for: textContainer)
            let textContainerOffset = CGPoint(x: (labelSize.width - textBoundingBox.size.width) * 0.5 - textBoundingBox.origin.x,
                                              y: (labelSize.height - textBoundingBox.size.height) * 0.5 - textBoundingBox.origin.y);
            let locationOfTouchInTextContainer = CGPoint(x: locationOfTouchInLabel.x - textContainerOffset.x,
                                                         y: locationOfTouchInLabel.y - textContainerOffset.y);
            let indexOfCharacter = layoutManager.characterIndex(for: locationOfTouchInTextContainer, in: textContainer, fractionOfDistanceBetweenInsertionPoints: nil)

            return NSLocationInRange(indexOfCharacter, targetRange)
        }
    }
    
}

extension NSAttributedString {
    static var linkAppearanceAttributes: [NSAttributedString.Key: Any] {
        [.foregroundColor: UIColor.blue, .underlineStyle: 1]
    }
}

extension String {
    public func ranges(of string: String) -> Array<NSRange> {
        var searchRange = NSMakeRange(0, self.count)
        var ranges : Array<NSRange> = []
        
        while searchRange.location < self.count {
            searchRange.length = self.count - searchRange.location
            let foundRange = (self as NSString).range(of: string, options: .caseInsensitive, range: searchRange)
            if foundRange.location != NSNotFound {
                ranges.append(foundRange)
                searchRange.location = foundRange.location + foundRange.length
            } else {
                break
            }
        }
        return ranges
    }
}
