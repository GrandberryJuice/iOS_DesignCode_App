//
//  ProfileVC.swift
//  designCode
//
//  Created by KENNETH GRANDBERRY on 3/31/16.
//  Copyright © 2016 KENNETH GRANDBERRY. All rights reserved.
//

import UIKit
import Firebase

class ProfileVC: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {

   
    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var imageBackground: UIImageView!
    
    @IBOutlet weak var collectionView:UICollectionView!
    
    var customImages = CustomImages()
    var post = [Post]()
    
   
    
    override func viewDidLoad() {
         super.viewDidLoad()
        collectionView.delegate = self
        collectionView.dataSource = self
        
        //        scroller.contentInset = UIEdgeInsetsMake(0,0,400,0)
        customImages.circleImage(profileImage)
        customImages.BlurEffect(imageBackground)
        
        DataService.ds.REF_POST.observeEventType(.Value, withBlock:{ snapshot in
            print(snapshot.value)
            //clear before update
            //self.posts = []
            
            //Grab all snapshots and interate through each
            //snaps hold all data - key:value
            if let snapshots = snapshot.children.allObjects as? [FDataSnapshot] {
                
                for snap in snapshots {
                    
                    if let postDict = snap.value as? Dictionary<String, AnyObject> {
                        let key = snap.key
                        let post = Post(postKey: key, dictionary: postDict)
                   
                        self.post.append(post)
                    }
                }
            }
           
        })
        
    }
    
    override func viewWillLayoutSubviews() {
//        super.viewWillLayoutSubviews()
//        self.scroller.frame = self.view.bounds
//        self.scroller.contentSize.height = 500
//        self.scroller.contentSize.width = 0
    }
    
    @IBAction func CloseBtnPressed(sender: AnyObject) {
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let posts = post[indexPath.row]
        
        if let cell = collectionView.dequeueReusableCellWithReuseIdentifier("ProfileCell", forIndexPath: indexPath) as? ProfileCell {
            
           cell.ConfigureCell(posts)
            return cell
            
        } else {
            
            return ProfileCell()
        }
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return post.count
    }
    
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 1
    }
    
//    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
//        return collectionView
//    }
//    
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        return CGSizeMake(105, 105)
    }
}
