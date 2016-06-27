//
//  UITextField.swift
//  public
//
//  Created by umut on 4/16/16.
//  Copyright © 2016 Happy Hours. All rights reserved.
//

import Foundation

import UIKit


@objc



@IBDesignable class TextField: UITextField {
    
    @IBInspectable var placeholderColor: UIColor = UIColor.lightGrayColor() {
        didSet {
            let canEditPlaceholderColor = self.respondsToSelector(Selector("setAttributedPlaceholder:"))
            
            if (canEditPlaceholderColor) {
                self.attributedPlaceholder = NSAttributedString(string: placeholder!, attributes:[NSForegroundColorAttributeName: placeholderColor]);
            }
        }
    }
    
}