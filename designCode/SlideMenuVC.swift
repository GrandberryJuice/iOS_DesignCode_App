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
    let empty = Menu(Image: "", title: "")
    let list2 = Menu(Image: "Message.png", title: "Message")
    let list1 = Menu(Image:"profile-1.png", title: "Profile")
    let list3 = Menu(Image: "friends.png", title: "Friends")
    let list4 = Menu(Image: "timeline.png", title: "Timeline")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        drawRect()
        TableView.dataSource = self
        TableView.delegate = self
        
        menulists.append(empty)
        menulists.append(list1)
        menulists.append(list2)
        menulists.append(list3)
        menulists.append(list4)
        
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
        return menulists.count
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