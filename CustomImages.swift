//
//  CustomImages.swift
//  designCode
//
//  Created by KENNETH GRANDBERRY on 4/3/16.
//  Copyright © 2016 KENNETH GRANDBERRY. All rights reserved.
//

import UIKit

class CustomImages: UIImageView {

    
    
    override func awakeFromNib() {
        super.awakeFromNib()
       
    }
    
    //makes profile image a circle
    func circleImage(image:UIImageView) {
        image.layer.cornerRadius = image.frame.size.width / 2
        image.clipsToBounds = true
    }
    
    func BlurEffect(image:UIImageView) {
        let blurEffect = UIBlurEffect(style: UIBlurEffectStyle.Light)
        let blurView = UIVisualEffectView(effect: blurEffect)
        blurView.frame = image.bounds
        image.addSubview(blurView)
    }
    
}
