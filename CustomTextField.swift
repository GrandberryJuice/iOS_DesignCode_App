//
//  CustomTextField.swift
//  designCode
//
//  Created by KENNETH GRANDBERRY on 3/19/16.
//  Copyright © 2016 KENNETH GRANDBERRY. All rights reserved.
//

import UIKit


@IBDesignable
class CustomTextField : UITextField {

    @IBInspectable var inset: CGFloat = 0
    
    @IBInspectable var cornerRadius: CGFloat = 5.0 {
        didSet {
          setupVC()
        }
    }
    
    //when textfield is not being edited
    override func textRectForBounds(bounds: CGRect) -> CGRect {
     return  CGRectInset(bounds, inset, inset)
    }

    //when textfield is being editied
    override func editingRectForBounds(bounds: CGRect) -> CGRect {
        return textRectForBounds(bounds)
    }
    
    //setting the corner radius
    override func awakeFromNib() {
        self.layer.cornerRadius = 5.0
    }
    
    override func prepareForInterfaceBuilder() {
        setupVC()
    }
    
    
    func setupVC() {
        self.layer.cornerRadius = cornerRadius
    
    }
}

