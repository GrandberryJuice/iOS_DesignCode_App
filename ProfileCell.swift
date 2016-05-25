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
            // grab images from the firebase for gallary
            var imgUrl:NSURL = NSURL(string: post.imageUrl!)!
            let request:NSURLRequest = NSURLRequest(URL: imgUrl)
            let config = NSURLSessionConfiguration.defaultSessionConfiguration()
            let session = NSURLSession(configuration: config)
            
            let task = session.dataTaskWithRequest(request, completionHandler: {(data, response, error) in
                
                // notice that I can omit the types of data, response and error
                self.userUploadImage.image = UIImage(data:data!)
                
            });
            
            // do whatever you need with the task e.g. run
            task.resume()
        
        }
    }


}
// NSURLSession's dataTaskWithRequest instead