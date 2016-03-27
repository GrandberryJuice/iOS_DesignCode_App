//
//  SlideMenuVC.swift
//  designCode
//
//  Created by KENNETH GRANDBERRY on 3/20/16.
//  Copyright © 2016 KENNETH GRANDBERRY. All rights reserved.
//

import UIKit


class SlideMenuVC: UIViewController, UITableViewDataSource, UITableViewDelegate {
    @IBOutlet weak var menuProfileImage: UIImageView!
    @IBOutlet weak var TableView:UITableView!
    
    var menulists = [Menu]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        drawRect()
        TableView.dataSource = self
        TableView.delegate = self
        
        let menulist = Menu(Image: "", title: "Profile")
        menulists.append(menulist)
        
        TableView.reloadData()
    }
    
    
    func drawRect() {
        //to get a complete circle
        menuProfileImage.layer.cornerRadius = menuProfileImage.frame.size.width / 2
        //image not appear outside where it should go
        menuProfileImage.clipsToBounds = true
        menuProfileImage.clipsToBounds = true
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let menuList = menulists[indexPath.row]
        
        if let cell = tableView.dequeueReusableCellWithIdentifier("MenuCell") as? MenuCell {
            cell.ConfigureMenuCell(menuList)
            return cell
            
        } else {
            let cell = MenuCell()
            cell.ConfigureMenuCell(menuList)
            return cell
            
        
        }
        
    }
}