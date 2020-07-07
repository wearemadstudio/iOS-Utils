//
//  UILabel+Extensions.swift
//  Utils
//
//  Created by Николай Садчиков on 31/05/2019.
//  Copyright © 2019 wearemad. All rights reserved.
//

import UIKit

public extension UILabel {
    
    @IBInspectable
    var kerning: CGFloat {
        get {
            var range = NSRange(location: 0, length: (text ?? "").count)
            guard let kern = attributedText?.attribute(NSAttributedString.Key.kern, at: 0, effectiveRange: &range),
                let value = kern as? NSNumber
                else {
                    return 0
            }
            return CGFloat(value.floatValue)
        }
        set {
            var attText: NSMutableAttributedString

            if let attributedText = attributedText {
                attText = NSMutableAttributedString(attributedString: attributedText)
            } else if let text = text {
                attText = NSMutableAttributedString(string: text)
            } else {
                attText = NSMutableAttributedString(string: "")
            }

            let range = NSRange(location: 0, length: attText.length)
            attText.addAttribute(NSAttributedString.Key.kern, value: NSNumber(value: Float(newValue)), range: range)
            self.attributedText = attText
        }
    }
    
    func addImage(image: UIImage) {
        let attachment = NSTextAttachment()
        attachment.image = image
        let attachmentString = NSAttributedString(attachment: attachment)
        let text = self.text!.appending(" ")
        let myString = NSMutableAttributedString(string: text)
        myString.append(attachmentString)
        self.attributedText = myString
    }
    
    func adjustFontSizeToFit(minimumFontSize: CGFloat, maximumFontSize: CGFloat? = nil) {
        let maxFontSize = maximumFontSize ?? font.pointSize
        let constraintSize = CGSize(width: bounds.size.width, height: CGFloat(MAXFLOAT))
        
        for size in stride(from: maxFontSize, to: minimumFontSize, by: -CGFloat(10)) {
            let proposedFont = font.withSize(size)
            let labelSize = ((text ?? "") as String).boundingRect(with: constraintSize,
                                                                  options: .usesLineFragmentOrigin,
                                                                  attributes: [NSAttributedString.Key.font: proposedFont],
                                                                  context: nil)
            if labelSize.height <= bounds.size.height {
                font = proposedFont
                setNeedsLayout()
                break
            }
        }
    }
    
    func changeTextColorCycleAnimation(color: UIColor?, duration: TimeInterval) {
        guard let color = color else { return }
        let originColor = self.textColor
        
        UIView.transition(with: self, duration: duration, options: .transitionCrossDissolve, animations: {
            self.textColor = color
        }) { _ in
            UIView.transition(with: self, duration: duration, options: .transitionCrossDissolve, animations: {
                self.textColor = originColor
            }, completion: nil)
        }
    }
}
