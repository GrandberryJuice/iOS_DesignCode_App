//
//  CustomTextView.swift
//  designCode
//
//  Created by KENNETH GRANDBERRY on 4/3/16.
//  Copyright © 2016 KENNETH GRANDBERRY. All rights reserved.
//

import UIKit

class CustomTextView: UITextView {
    
     @IBOutlet weak var UsermessageText: UITextView!
    
    
    override func awakeFromNib() {
        textViewCornerDesign(UsermessageText)
    }
    
    //round edges, and add border
    func textViewCornerDesign(text:UITextView) {
        text.layer.borderColor = UIColor.blackColor().CGColor
        text.layer.borderWidth = 0.5
        text.layer.cornerRadius = 5
        
    }
    
}
