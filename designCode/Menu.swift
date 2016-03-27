//
//  Menu.swift
//  designCode
//
//  Created by KENNETH GRANDBERRY on 3/27/16.
//  Copyright © 2016 KENNETH GRANDBERRY. All rights reserved.
//

import Foundation

class Menu {
    
    private var _menuImage:String
    private var _menuTitle:String
    
    var menuImage:String {
       return  _menuImage
    }
    
    var menuTitle:String {
        return _menuTitle
    }

    init(Image:String, title:String) {
        self._menuImage = Image
        self._menuTitle = title
    
    }
    

}
