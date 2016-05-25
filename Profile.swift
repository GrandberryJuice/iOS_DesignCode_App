//
//  Profile.swift
//  designCode
//
//  Created by KENNETH GRANDBERRY on 5/16/16.
//  Copyright © 2016 KENNETH GRANDBERRY. All rights reserved.
//

import Foundation

class Profile {
    private var _imageGallery:[String]?
    private var _user:String?
    private var _profileImage:String?
    
    var imageGallery:[String]? { return _imageGallery }
    
    var user: String? { return _user }
    
    var profileImage:String? { return _profileImage }
    
    init(user:String, imgUrl:[String]) {
        self._user = user
        self._imageGallery = imgUrl
    }
    
    init(profileImage:String) {
        self._profileImage = profileImage
    }
    
}

