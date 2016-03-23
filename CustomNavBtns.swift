//
//  CustomNavBtns.swift
//  designCode
//***Should be renamed to CustomNavigationView
//
//  Created by KENNETH GRANDBERRY on 3/22/16.
//  Copyright © 2016 KENNETH GRANDBERRY. All rights reserved.
//

import UIKit

class CustomNavBtns: UINavigationBar {
    
    func CustomMenuBtn() ->UIButton {
        let MenuBtn:UIButton = UIButton(frame: CGRectMake(0,0,25,25))
        MenuBtn.setImage(UIImage(named:"MenuBtn"), forState: .Normal)
        
        return MenuBtn
    }
 
}
