//
//  FriendsVC.swift
//  designCode
//
//  Created by KENNETH GRANDBERRY on 4/9/16.
//  Copyright © 2016 KENNETH GRANDBERRY. All rights reserved.
//

import UIKit
import Firebase

class FriendsVC: UIViewController, UITableViewDelegate, UITableViewDataSource {

    var userInfo = [UserInfo]()
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var closeButton: UIButton!
    
    var customImages = CustomImages()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
      
        DataService.ds.REF_USERINFO.observeEventType(.Value, withBlock:{ snapshot in
            //takes a snap shot of the data in Firebase
            if let snapshots = snapshot.children.allObjects as? [FDataSnapshot] {
                for snap in snapshots {
                    if let postDict = snap.value as? Dictionary<String, AnyObject> {
                        let key = snap.key
                        let friends = UserInfo(username: key, dictionary: postDict)
                        self.userInfo.append(friends)
                    }
                }
            }
            self.tableView.reloadData()
        })
    }
    
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let data = userInfo[indexPath.row]
        
       if let cell = tableView.dequeueReusableCellWithIdentifier("friendsCell", forIndexPath: indexPath) as? FriendsCell {
            cell.configureCell(data)
            return cell
       } else {
        return FriendsCell()
        }
        
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return userInfo.count
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    @IBAction func closeBtn(sender: AnyObject) {
        self.dismissViewControllerAnimated(true, completion: {})
        if (self.revealViewController() != nil) {
            self.revealViewController().revealToggleAnimated(true)
        }
    }
    
}
