//
//  TimeLineVC.swift
//  designCode
//
//  Created by KENNETH GRANDBERRY on 3/20/16.
//  Copyright © 2016 KENNETH GRANDBERRY. All rights reserved.
//

import UIKit

class TimeLineVC: UIViewController {
    
//    @IBOutlet weak var BtnMenu: UIButton!
    //@IBOutlet weak var MenuBtn:UIButtonItem!
 //   @IBOutlet weak var MenuBtn: UIButton!
    
    @IBOutlet weak var Menu: UIBarButtonItem!
    override func viewDidLoad() {
        super.viewDidLoad()
    
        Menu.target = self.revealViewController()
        Menu.action = Selector("revealToggle:")
        
        self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
    }

}
