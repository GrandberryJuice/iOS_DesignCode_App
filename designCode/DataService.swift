//
//  DataService.swift
//  designCode
//
//  Created by KENNETH GRANDBERRY on 3/20/16.
//  Copyright © 2016 KENNETH GRANDBERRY. All rights reserved.
//

import UIKit
import Firebase

class DataService {
    //static service
    static let ds = DataService()
    
    private var _REF_BASE = Firebase(url:"https://design-code.firebaseio.com")
    
    var  REF_BASE: Firebase {
        return _REF_BASE
    }

}