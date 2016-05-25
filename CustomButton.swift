//
//  CustomButton.swift
//  designCode
//
//  Created by KENNETH GRANDBERRY on 3/19/16.
//  Copyright © 2016 KENNETH GRANDBERRY. All rights reserved.
//

import UIKit
import pop

@IBDesignable
class CustomButton: UIButton {
    
    //default corners
    @IBInspectable var cornerRadius: CGFloat = 3.0 {
        didSet {
            setupView()
        }
    }
    
    //Default text color
    @IBInspectable var fontColor: UIColor = UIColor.whiteColor() {
        didSet {
            self.tintColor = fontColor
        }
    }
    
    override func awakeFromNib() {
        setupView()
    }
    
    override func prepareForInterfaceBuilder() {
        super.prepareForInterfaceBuilder()
        setupView()
    }
    
    //View setup for annimation and design
    func setupView() {
        self.layer.cornerRadius = cornerRadius
        self.addTarget(self, action: "scaleToSmall", forControlEvents: .TouchDown)
        self.addTarget(self, action: "scaleToSmall", forControlEvents: .TouchDragEnter)
        self.addTarget(self, action: "scaleAnimation", forControlEvents: .TouchUpInside)
        self.addTarget(self, action: "scaleDefault", forControlEvents: .TouchDragExit)
    }
    
    //make annimation small
    func scaleToSmall() {
        let scaleAnim = POPBasicAnimation(propertyNamed: kPOPLayerScaleXY)
        scaleAnim.toValue = NSValue(CGSize:CGSizeMake(0.95, 0.95))
        //arbitrary name given in "String"
        self.layer.pop_addAnimation(scaleAnim, forKey: "layerScaleSmallAnimation")
    }
    
    //make spring type of animation
    func scaleAnimation() {
        let scaleAnim = POPSpringAnimation(propertyNamed: kPOPLayerScaleXY)
        //spring same on x and y
        scaleAnim.velocity = NSValue(CGSize:CGSizeMake(3.0,3.0))
        //once done spring- goes back to normal
        scaleAnim.toValue = NSValue(CGSize: CGSizeMake(1.0,1.0))
        scaleAnim.springBounciness = 18
        self.layer.pop_addAnimation(scaleAnim, forKey: "layerScaleSpringAnimation")
        
    }
    
    func scaleDefault() {
        let scaleAnim = POPBasicAnimation(propertyNamed: kPOPLayerScaleXY)
        scaleAnim.toValue = NSValue(CGSize: CGSizeMake(1,1))
        self.layer.pop_addAnimation(scaleAnim, forKey: "layerScaleSpringAnimation")
    
    }
    
    
}
