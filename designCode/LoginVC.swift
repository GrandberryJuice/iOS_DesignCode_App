//
//  ViewController.swift
//  designCode
//
//  Created by KENNETH GRANDBERRY on 3/18/16.
//  Copyright © 2016 KENNETH GRANDBERRY. All rights reserved.
//

import UIKit
import pop


class LoginVC: UIViewController {
    //Constraints
    @IBOutlet weak var loginBtnConstraint: NSLayoutConstraint!
    @IBOutlet weak var emailConstraint: NSLayoutConstraint!
    @IBOutlet weak var passwordConstraint: NSLayoutConstraint!
    
    var animEngine: AnimationEngine!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.animEngine = AnimationEngine(constraints: [emailConstraint,passwordConstraint,loginBtnConstraint])
    }
    
    override func viewDidAppear(animated: Bool) {
        self.animEngine.animateOnScreen(1)
    }



}

//Standard UIAnnimation -just in case
//    override func viewDidAppear(animated: Bool) {
//        UIView.animateWithDuration(6) { () -> Void in
//            self.emailConstraint.constant = -100
//            self.view.layoutIfNeeded()
//        }
//    }