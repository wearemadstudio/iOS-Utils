//
//  UILabel+Extensions.swift
//  Utils
//
//  Created by Николай Садчиков on 31/05/2019.
//  Copyright © 2019 wearemad. All rights reserved.
//

import UIKit

extension UILabel {
    
    public func addImage(image: UIImage) {
        let attachment = NSTextAttachment()
        attachment.image = image
        let attachmentString = NSAttributedString(attachment: attachment)
        let text = self.text!.appending(" ")
        let myString = NSMutableAttributedString(string: text)
        myString.append(attachmentString)
        self.attributedText = myString
    }
}
