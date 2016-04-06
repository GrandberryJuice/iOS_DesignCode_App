//
//  ProfileVC.swift
//  designCode
//
//  Created by KENNETH GRANDBERRY on 3/31/16.
//  Copyright © 2016 KENNETH GRANDBERRY. All rights reserved.
//

import UIKit

class ProfileVC: UIViewController {

   
    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var imageBackground: UIImageView!
    
    
    
    var customImages = CustomImages()
    
    
    override func viewDidLoad() {
         super.viewDidLoad()
//        scroller.contentInset = UIEdgeInsetsMake(0,0,400,0)
        customImages.circleImage(profileImage)
        customImages.BlurEffect(imageBackground)

        }
    
    override func viewWillLayoutSubviews() {
//        super.viewWillLayoutSubviews()
//        self.scroller.frame = self.view.bounds
//        self.scroller.contentSize.height = 500
//        self.scroller.contentSize.width = 0
    }
    
    @IBAction func CloseBtnPressed(sender: AnyObject) {
        dismissViewControllerAnimated(true, completion: nil)
    }
}
