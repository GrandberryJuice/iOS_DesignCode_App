//
//  MenuCell.swift
//  designCode
//
//  Created by KENNETH GRANDBERRY on 3/27/16.
//  Copyright © 2016 KENNETH GRANDBERRY. All rights reserved.
//

import UIKit

class MenuCell: UITableViewCell {
    @IBOutlet weak var menuIcon:UIImageView!
    @IBOutlet weak var menuTitle:UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func ConfigureMenuCell(menu:Menu) {
        menuTitle.text = menu.menuTitle
    }
    
}
