//
//  FriendsCell.swift
//  designCode
//
//  Created by KENNETH GRANDBERRY on 4/9/16.
//  Copyright © 2016 KENNETH GRANDBERRY. All rights reserved.
//

import UIKit

class FriendsCell: UITableViewCell {
    
    @IBOutlet weak var FriendImage:UIImageView!
    @IBOutlet weak var FriendName:UILabel!
    
     var customImages = CustomImages()
    
    var userInfo:UserInfo!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func configureCell(friends:UserInfo) {
        
        //if ((friends.profileImage) != nil) {
            // grab images from the firebase for gallary
            var imgUrl:NSURL = NSURL(string: friends.profileImage)!
            let request:NSURLRequest = NSURLRequest(URL: imgUrl)
            let config = NSURLSessionConfiguration.defaultSessionConfiguration()
            let session = NSURLSession(configuration: config)
            
            let task = session.dataTaskWithRequest(request, completionHandler: {(data, response, error) in
                
                // notice that I can omit the types of data, response and error
                self.FriendImage.image = UIImage(data:data!)
                
                
                
            });
        
            customImages.circleImage(self.FriendImage)
            // do whatever you need with the task e.g. run
            task.resume()
        //image needs to be changed to download image from imageshack
        self.FriendImage.image = UIImage(named: friends.profileImage)
     //   self.FriendName.text = friends.Username
     
        //let FRIENDS_REF = DataService.ds.REF_USER_CURRENT.childByAppendingPath("friends").childByAppendingPath(userInfo.Username)
        self.FriendName.text = friends.Username
    }
    
    
}
