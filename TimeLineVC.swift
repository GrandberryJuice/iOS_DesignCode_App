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
    static var proCache = NSCache()
    
    //Classes
    var customNavBtn = CustomNavBtns()
    
    let postcell = PostCell()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
        
//        let tappedUserName = UITapGestureRecognizer(target: self, action: "profileNameTapped:")
//        tappedUserName.numberOfTapsRequired = 1
//        postcell.profileName.addGestureRecognizer(tappedUserName)
//        //profileName.addGestureRecognizer(tappedUserName)
//        postcell.profileName.userInteractionEnabled = true
        
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
        


        tableView.delegate = self
        tableView.dataSource = self
        
        //*Value- anydata changes
        //called when ever data is changed
        DataService.ds.REF_POST.observeEventType(.Value, withBlock:{ snapshot in
            //Grab all snapshots and interate through each
            //snaps hold all data - key:value
            print(snapshot.value)
            if let snapshots = snapshot.children.allObjects as? [FDataSnapshot] {
                for snap in snapshots {
                    //post Descritpions and username
                    if let postDict = snap.value as? Dictionary<String, AnyObject> {
                        let key = snap.key
                        let post = Post(postKey: key, dictionary: postDict)
                        self.posts.append(post)
                    }
                }
                
            }
            self.tableView.reloadData()
            let tappedUserName = UITapGestureRecognizer(target: self, action: "profileNameTapped:")
            tappedUserName.numberOfTapsRequired = 1
            if let profileName = self.postcell.profileName {
                profileName.addGestureRecognizer(tappedUserName)
                profileName.userInteractionEnabled = true
                
            }
        })
        print(self.postcell.profileName.text)
    }
    
    
//    override func awakeFromNib() {
//        let tappedUserName = UITapGestureRecognizer(target: self, action: "profileNameTapped:")
//        tappedUserName.numberOfTapsRequired = 1
//        postcell.profileName.addGestureRecognizer(tappedUserName)
//        //profileName.addGestureRecognizer(tappedUserName)
//        postcell.profileName.userInteractionEnabled = true
//    }
    
    
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
            var profimg:UIImage?
            
            if let proimg = post.postProfileImage {
                profimg = TimeLineVC.proCache.objectForKey(proimg) as? UIImage
            }
            //call function in Postcell
            cell.configureCell(post, img:img, proimg:profimg)
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
    
//    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
//        <#code#>
//    }
    
    
    
    func profileNameTapped() {
        self.performSegueWithIdentifier("UserProfileVC", sender: nil)
        
    }
    

    
}

    



//right button for post
//         UIBarButtonItem.appearance().tintColor = UIColor.whiteColor()
//        let rightBarBtn = UIBarButtonItem()
//        rightBarBtn.customView = PostBtn
//        self.navigationItem.leftBarButtonItem = rightBarBtn
