//
//  UILabel.swift
//  Instalker
//
//  Created by umut on 18/02/16.
//  Copyright © 2016 SmartClick. All rights reserved.
//


import UIKit

@objc
@IBDesignable
class Label:UILabel{
    @IBInspectable var insetX: CGFloat = 0
    @IBInspectable var insetY: CGFloat = 0
    
//    override func textRectForBounds(bounds: CGRect, limitedToNumberOfLines numberOfLines: Int) -> CGRect {
//        return CGRectInset(bounds, insetX, insetY)
//    }
//    
//    override func drawTextInRect(rect: CGRect) {
//        var insets: UIEdgeInsets = UIEdgeInsets(top: 0.0, left: 10.0, bottom: 0.0, right: 10.0)
//        super.drawTextInRect(UIEdgeInsetsInsetRect(rect, insets))
//    }
    
}

