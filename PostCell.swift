//
//  PostCell.swift
//  designCode
//
//  Created by KENNETH GRANDBERRY on 3/21/16.
//  Copyright © 2016 KENNETH GRANDBERRY. All rights reserved.
//

import UIKit

class PostCell: UITableViewCell {
    
    @IBOutlet weak var profileImg:UIImageView!
    @IBOutlet weak var showcaseImg:UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
     
    
    }
    
    //after a profile image has a size
    override func drawRect(rect: CGRect) {
        //to get a complete circle
        profileImg.layer.cornerRadius = profileImg.frame.size.width / 2
        //image not appear outside where it should go
        profileImg.clipsToBounds = true
        showcaseImg.clipsToBounds = true
        
    }
    
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    
    
    
    

}
