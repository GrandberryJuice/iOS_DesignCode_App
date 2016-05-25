//
//  CustomMessageVC.swift
//  designCode
//
//  Created by KENNETH GRANDBERRY on 4/2/16.
//  Copyright © 2016 KENNETH GRANDBERRY. All rights reserved.
//

import UIKit

class CustomMessageVC:UIViewController {

    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var UsermessageText: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        circleImage()
        textViewCornerDesign()
    }
    
    //makes profile image a circle
    func circleImage() {
        profileImage.layer.cornerRadius = profileImage.frame.size.width / 2
    }
    
    //round edges, and add border
    func textViewCornerDesign() {
        UsermessageText.layer.borderColor = UIColor.blackColor().CGColor
        UsermessageText.layer.borderWidth = 0.5
        UsermessageText.layer.cornerRadius = 5
        
    }

}