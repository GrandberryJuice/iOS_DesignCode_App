//
//  PostCell.swift
//  designCode
//
//  Created by KENNETH GRANDBERRY on 3/21/16.
//  Copyright © 2016 KENNETH GRANDBERRY. All rights reserved.
//

import UIKit
import Alamofire
import Firebase

class PostCell: UITableViewCell {
    
    @IBOutlet weak var profileImg:UIImageView!
    @IBOutlet weak var showcaseImg:UIImageView!
    @IBOutlet weak var descriptionText:UITextView!
    @IBOutlet weak var likesLbl:UILabel!
    @IBOutlet weak var likeImage:UIImageView!
    
    //store post
    var post:Post!
    var likeRef:Firebase!
    
    //Alamofire request
    var request:Request?

    override func awakeFromNib() {
        super.awakeFromNib()
        let tap = UITapGestureRecognizer(target: self, action: "likeTapped:")
        tap.numberOfTapsRequired = 1
        likeImage.addGestureRecognizer(tap)
        likeImage.userInteractionEnabled = true
        
    }
    
    //Circle profile image in tableView
    override func drawRect(rect: CGRect) {
        profileImg.layer.cornerRadius = profileImg.frame.size.width / 2
        profileImg.clipsToBounds = true
        showcaseImg.clipsToBounds = true
        
    }
    
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    /*
        configuring the tableView cell
        set up for likes,label, image request
    */
    func configureCell(post:Post, img:UIImage?) {
        self.post = post
        //get current users likes, and grab post key
        likeRef = DataService.ds.REF_USER_CURRENT.childByAppendingPath("likes").childByAppendingPath(post.postKey)
        
        self.descriptionText.text = post.postDesc
        self.likesLbl.text = "\(post.likes)"
        
            if post.imageUrl != nil {
                if img != nil {
                    self.showcaseImg.image = img
                } else {
                    request = Alamofire.request(.GET, post.imageUrl!).validate(contentType:["image/*"]).response(completionHandler: { request, response, data, error in
                        if error == nil {
                            //do error checking
                            let img = UIImage(data: data!)!
                            self.showcaseImg.image = img
                      
                            TimeLineVC.imageCache.setObject(img, forKey: self.post.imageUrl!)
                            self.showcaseImg.hidden = false
                        } else {
                            print(error.debugDescription)
                        }
                    
                    })
                }
            } else {

        }
        //only called once
        likeRef.observeSingleEventOfType(.Value, withBlock: { snapshot in
            /*
            * if there are no likes - if there is no data value
            * it comes back as NSNull in FIREBASE
            */
            if let doesNotExist = snapshot.value as? NSNull {
                self.likeImage.image = UIImage(named: "heart-empty")
            } else {
                self.likeImage.image = UIImage(named: "heart-full")
            }
        })
    }
    
    func likeTapped (sender:UITapGestureRecognizer) {
        //only called once
        likeRef.observeSingleEventOfType(.Value, withBlock: { snapshot in
            /*
            * if there are no likes - if there is no data value
            * it comes back as NSNull in FIREBASE
            */
            if let doesNotExist = snapshot.value as? NSNull {
                self.likeImage.image = UIImage(named: "heart-full")
                self.post.adjustLikes(true)
                //set value save the reference and add to firebase
                self.likeRef.setValue(true)
            } else {
                   self.likeImage.image = UIImage(named: "heart-empty")
                    self.post.adjustLikes(false)
                    self.likeRef.removeValue()
            }
        })
    }
    
        
}
