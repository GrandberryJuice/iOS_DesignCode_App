//
//  Post.swift
//  designCode
//
//  Created by KENNETH GRANDBERRY on 3/22/16.
//  Copyright © 2016 KENNETH GRANDBERRY. All rights reserved.
//

import Foundation
import Firebase

class Post {
    private var _postDesc: String!
    private var _imageUrl:String?
    private var _likes: Int!
    private var _username:String!
    private var _postKey:String!
    private var _postRef:Firebase!
    
    
    var postDesc:String {
        return _postDesc
    }
    
    var likes:Int {
    
        return _likes
    }

    var username:String {
        return _username
    }
    
    var postKey:String {
        return _postKey
    }
    
    var imageUrl:String? {
        return _imageUrl
    }
    
    
    init(description:String, imageUrl:String?, username:String ) {
        self._postDesc = description
        self._imageUrl = imageUrl
        self._username = username
        
    }
    
    //when receiving data back from firebase
    init(postKey:String, dictionary:Dictionary<String,AnyObject>) {
    
        self._postKey = postKey
        
        if let likes = dictionary["likes"] as? Int {
            self._likes = likes
        }
        
        if let imgUrl = dictionary["imageUrl"] as? String {
            self._imageUrl = imgUrl
        }
        
        if let desc = dictionary["description"] as? String {
            self._postDesc = desc
        }
        
        //reference to posts
        self._postRef = DataService.ds.REF_POST.childByAppendingPath(self.postKey)
    }
    
    
    func adjustLikes(addLike:Bool) {
        if addLike {
            _likes = _likes + 1
        } else {
            _likes = _likes - 1
        }
        
        _postRef.childByAppendingPath("likes").setValue(_likes)
    }
    
}