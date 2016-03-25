//
//  PostCell.swift
//  designCode
//
//  Created by KENNETH GRANDBERRY on 3/21/16.
//  Copyright © 2016 KENNETH GRANDBERRY. All rights reserved.
//

import UIKit
import Alamofire

class PostCell: UITableViewCell {
    
    @IBOutlet weak var profileImg:UIImageView!
    @IBOutlet weak var showcaseImg:UIImageView!
    @IBOutlet weak var descriptionText:UITextView!
    @IBOutlet weak var likesLbl:UILabel!
    
    //store post
    var post:Post!
    
    //Alamofire request
    var request:Request?

    
  
    override func awakeFromNib() {
        super.awakeFromNib()
//            print(data)
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
    
    
    func configureCell(post:Post, img:UIImage?) {
        self.post = post
        
        self.descriptionText.text = post.postDesc
        self.likesLbl.text = "\(post.likes)"
        
        print(post.imageUrl)
        
        if post.imageUrl != nil {
            
            if img != nil {
                self.showcaseImg.image = img
            } else {
                
                request = Alamofire.request(.GET, post.imageUrl!).validate(contentType:["image/*"]).response(completionHandler: { request, response, data, error in
                    //check if there is a value
                    print(data)
 
                    if error == nil {
                        //do error checking
                        let img = UIImage(data: data!)!
                        self.showcaseImg.image = img
                        TimeLineVC.imageCache.setObject(img, forKey: self.post.imageUrl!)
                        
                    }
                })
            }
        } else {
            self.showcaseImg.hidden = true
        }
        
    }
    
    

    
    
        
}
