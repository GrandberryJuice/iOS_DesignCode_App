//
//  ProfileCell.swift
//  designCode
//
//  Created by KENNETH GRANDBERRY on 4/6/16.
//  Copyright © 2016 KENNETH GRANDBERRY. All rights reserved.
//

import UIKit

class ProfileCell: UICollectionViewCell {
    
    @IBOutlet weak var userUploadImage:UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    var post:Post!
    
    func ConfigureCell(post:Post) {
        
        if ((post.imageUrl) != nil) {
            userUploadImage.image = UIImage(named:post.imageUrl!)
        }
        
    }
    
}
