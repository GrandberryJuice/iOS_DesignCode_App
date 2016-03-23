//
//  TimeLineVC.swift
//  designCode
//
//  Created by KENNETH GRANDBERRY on 3/20/16.
//  Copyright © 2016 KENNETH GRANDBERRY. All rights reserved.
//

import UIKit
import Firebase

class TimeLineVC: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    //Outlets
    @IBOutlet weak var tableView:UITableView!
    var posts = [Post]()
    
    //Classes
    var customNavBtn = CustomNavBtns()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
        
        let Menu = customNavBtn.CustomMenuBtn()
        Menu.addTarget(self.revealViewController(), action:Selector("revealToggle:"), forControlEvents: .TouchUpInside)
        
        //convert back to barbtn
        let leftBarBtn = UIBarButtonItem()
        leftBarBtn.customView = Menu
        self.navigationItem.rightBarButtonItem = leftBarBtn

        tableView.delegate = self
        tableView.dataSource = self
        
        //*Value-anydata changes
        //called when ever data is changed
        DataService.ds.REF_POST.observeEventType(.Value, withBlock:{ snapshot in
            print(snapshot.value)
            //clear before update
            self.posts = []
            
            //Grab all snapshots and interate through each
            if let snapshots = snapshot.children.allObjects as? [FDataSnapshot] {
                
                for snap in snapshots {
                    print("SNAP:\(snap)")
                    
                    if let postDict = snap.value as? Dictionary<String, AnyObject> {
                      let key = snap.key
                        let post = Post(postKey: key, dictionary: postDict)
                        self.posts.append(post)
                    }
                }
            }
            self.tableView.reloadData()
        })
    }
    
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let post = posts[indexPath.row]
        return tableView.dequeueReusableCellWithIdentifier("PostCell") as! PostCell
        
        
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return posts.count
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    

}
