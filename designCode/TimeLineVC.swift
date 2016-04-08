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
    static var imageCache = NSCache()
    
    //Classes
    var customNavBtn = CustomNavBtns()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
        
        //set view height
        tableView.estimatedRowHeight = 370
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "onPostLoaded:", name: "postsLoaded", object: nil)
        
        let Menu = customNavBtn.CustomMenuBtn()
//        let PostBtn = customNavBtn.CustomPostBtn()
        
        Menu.addTarget(self.revealViewController(), action:Selector("revealToggle:"), forControlEvents: .TouchUpInside)
        
        //left button for message
        //converted for use
        let leftBarBtn = UIBarButtonItem()
        leftBarBtn.customView = Menu
        self.navigationItem.rightBarButtonItem = leftBarBtn
        
        //right button for post
//         UIBarButtonItem.appearance().tintColor = UIColor.whiteColor()
//        let rightBarBtn = UIBarButtonItem()
//        rightBarBtn.customView = PostBtn
//        self.navigationItem.leftBarButtonItem = rightBarBtn

        tableView.delegate = self
        tableView.dataSource = self
        
        //*Value-anydata changes
        //called when ever data is changed
        DataService.ds.REF_POST.observeEventType(.Value, withBlock:{ snapshot in
            //print(snapshot.value)
            //clear before update
            //self.posts = []
            
            //Grab all snapshots and interate through each
            //snaps hold all data - key:value
            if let snapshots = snapshot.children.allObjects as? [FDataSnapshot] {
                
                for snap in snapshots {
                    
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
        
        if let cell = tableView.dequeueReusableCellWithIdentifier("PostCell") as? PostCell {
            cell.request?.cancel()
            
            //create a empty image
            var img:UIImage?

            if let url = post.imageUrl {
                //store the image and cache
                img = TimeLineVC.imageCache.objectForKey(url) as? UIImage
            }
            //call function in Postcell
            cell.configureCell(post,img:img)
            return cell
            
        } else {
            return PostCell()
        }  
        
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return posts.count
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        let post = posts[indexPath.row]
        
        /* if there is no image in the tableView
         *   make the view smaller
        */
        if post.imageUrl == nil {
            return 150
        } else {
        
            return tableView.estimatedRowHeight
        }
    }
    
    func onPostLoaded(notification:NSNotification) {
        posts.removeAll()
        self.tableView.reloadData()
    }
    
    

}
