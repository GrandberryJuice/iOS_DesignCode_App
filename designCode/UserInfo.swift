//
//  UserInfo.swift
//  designCode
//
//  Created by KENNETH GRANDBERRY on 4/10/16.
//  Copyright © 2016 KENNETH GRANDBERRY. All rights reserved.
//

import Foundation
import Firebase

class UserInfo {
    
    private var _aboutMe:String!
    private var _email:String!
    private var _friends:Int!
    private var _profileImage:String!
    private var _UserInfoRef:Firebase!
    private var _Username:String
    
    //Globals
    
    var aboutMe:String {
        return _aboutMe
    }
    
    var email:String {
        return _email
    }
    
    
    var friends:Int {
        return _friends
    }
    
    var profileImage:String {
        return _profileImage
    }
    
    var Username:String {
        return _Username
    }
    
    init(username:String, image:String) {
        self._Username = username
        self._profileImage = image
    }
    
  
    init(username:String, dictionary:Dictionary<String,AnyObject>) {
        
        self._Username = username
        
        if let aboutme = dictionary["aboutme"] as? String {
            self._aboutMe = aboutme
        }
        
        if let email = dictionary["email"] as? String {
            self._email = email
        }
        
        if let friends = dictionary["friends"] as? Int {
            self._friends = friends
        }
        
        if let profileImage = dictionary["profileImage"] as? String {
            self._profileImage = profileImage
        
        }
        
        
        self._UserInfoRef = DataService.ds.REF_USERINFO.childByAppendingPath(self.Username)
    }
    
    func adjustFriends(addFriends:Bool) {
        if addFriends {
            _friends = _friends + 1
        } else {
            _friends = _friends - 1
        }
        
        _UserInfoRef.childByAppendingPath("friends").setValue(_friends)
    }

}