//
//  AnimationEngine.swift
//  designCode
//
//  Created by KENNETH GRANDBERRY on 3/19/16.
//  Copyright © 2016 KENNETH GRANDBERRY. All rights reserved.
//


import UIKit
import pop

class AnimationEngine {
    
    
    
    class var offScreenRightPosition:CGPoint {
        return CGPointMake(UIScreen.mainScreen().bounds.width, CGRectGetMidY(UIScreen.mainScreen().bounds))
    }
    
    class var offScreenLeftPosition:CGPoint {
        return CGPointMake(-UIScreen.mainScreen().bounds.width, CGRectGetMidY(UIScreen.mainScreen().bounds))
    
    }

    class var screenCenterPositon: CGPoint {
    
        return CGPointMake(CGRectGetMidX(UIScreen.mainScreen().bounds), CGRectGetMidY(UIScreen.mainScreen().bounds))
    }
    
    
    //must use a int value
    let ANIM_DELAY : Int = 1
    var originalConstants = [CGFloat]()
    var constraints: [NSLayoutConstraint]!
    
    //pass in many constraints for animation to go off screen
    init(constraints: [NSLayoutConstraint]) {
        //store orignal constraints
        for con in constraints {
            originalConstants.append(con.constant)
            //move off screen before seen
            con.constant = AnimationEngine.offScreenRightPosition.x
        }
        self.constraints = constraints
    }
    
    
    
    
    func animateOnScreen(delay:Int) {
        
            //if delay is nil perform other go with delay
        
        let time = dispatch_time(DISPATCH_TIME_NOW, Int64(Double(delay) * Double(NSEC_PER_SEC)))
        dispatch_after(time,dispatch_get_main_queue()) {
            var index = 0
            
            repeat {
                let moveAnim = POPSpringAnimation(propertyNamed: kPOPLayoutConstraintConstant)
                moveAnim.toValue = self.originalConstants[index]
                moveAnim.springBounciness = 12
                moveAnim.springSpeed = 12
                
                
                if(index > 0) {
                    moveAnim.dynamicsFriction += 2 + CGFloat(index)
                }
            
                let con = self.constraints[index]
                con.pop_addAnimation(moveAnim, forKey: "moveOnScreen")
                index++
                
            }while(index < self.constraints.count)
        }
        
    
    }
    
}