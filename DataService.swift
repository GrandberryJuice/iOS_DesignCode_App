//
//  DataService.swift
//  designCode
//
//  Created by KENNETH GRANDBERRY on 3/20/16.
//  Copyright © 2016 KENNETH GRANDBERRY. All rights reserved.
//

import UIKit
import Firebase

let URL_BASE = "https://design-code.firebaseio.com"

class DataService {
    //static service
    static let ds = DataService()
    
    private var _REF_BASE = Firebase(url:"\(URL_BASE)")
    private var _REF_POST = Firebase(url: "\(URL_BASE)/post")
    private var _REF_USERS = Firebase(url: "\(URL_BASE)/users")
    private var _REF_USERINFO = Firebase(url:"\(URL_BASE)/UserInfo")
    
    var  REF_BASE: Firebase {
        return _REF_BASE
    }
    
    var REF_POST:Firebase {
        return _REF_POST
    }
    
    
    var REF_USERS:Firebase {
        return _REF_USERS
    }
    
    var REF_USER_CURRENT:Firebase {
        let uid = NSUserDefaults.standardUserDefaults().valueForKey(KEY_UID) as! String
        let user = Firebase(url: "\(URL_BASE)").childByAppendingPath("users").childByAppendingPath(uid)
        return user!
    }
    
    
    var REF_USERINFO:Firebase {
        return _REF_USERINFO
    }
    
    //set up a variable to user profile to just call upon
//    var REF_USER_ProfilePic:Firebase {
//    
//    
//    }
    
    //
    func createFirebaseUsers(uid:String, user:Dictionary<String,String>) {
        //get uid from users and save it even it dosent exist 
        //it will create it and set the use value
        REF_USERS.childByAppendingPath(uid).setValue(user)
        
    }
}