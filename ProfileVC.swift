//
//  ProfileVC.swift
//  designCode
//
//  Created by KENNETH GRANDBERRY on 3/31/16.
//  Copyright © 2016 KENNETH GRANDBERRY. All rights reserved.
//

//option click on function

import UIKit
import Firebase
import Alamofire

class ProfileVC: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout,UIImagePickerControllerDelegate, UINavigationControllerDelegate {

   
    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var imageBackground: UIImageView!
    @IBOutlet weak var collectionView:UICollectionView!
    
    var customImages = CustomImages()
 
  
    static var imageCache = NSCache()
    var imagePicker: UIImagePickerController!
    var CURRENT_USER_IMAGE:Firebase!
    var CURRENT_USER_GALLERY:Firebase!
    var gallery = [Profile]()
    var galleryImages = [String]()
    var isOneImage = false
    var oneImageGallery = ""
    var CURRENT_USER:Firebase!

    //MARK: TODO - Check if snaps are empty
    override func viewDidLoad() {
         super.viewDidLoad()
        collectionView.delegate = self
        collectionView.dataSource = self
        imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        customImages.circleImage(profileImage)
        customImages.BlurEffect(imageBackground)
        CURRENT_USER_IMAGE = DataService.ds.REF_USER_CURRENT.childByAppendingPath("profileImage")
        CURRENT_USER_GALLERY = DataService.ds.REF_USER_CURRENT.childByAppendingPath("imageGallery")
        CURRENT_USER = DataService.ds.REF_USER_CURRENT
        let uid = NSUserDefaults.standardUserDefaults().valueForKey(KEY_UID) as! String

        /**
            Grabes the current user images from firebase
            & caches the images
            
            -snapshot: Data from firebase
         */
        
        CURRENT_USER_GALLERY.observeSingleEventOfType(.Value, withBlock:{ snapshot in
            if let snapshots = snapshot.children.allObjects as? [FDataSnapshot] {
                if snapshots.isEmpty {
                    self.oneImageGallery = snapshot.value as! String
                    self.isOneImage = true
                } else {
                    var imageHolds: [String] = []
                    for snap in snapshots {
                        if let testing = snap.value as? String{ imageHolds.append(testing) }
                        let data = Profile(user:uid,imgUrl:imageHolds)
                        self.gallery.append(data)
                        self.isOneImage = false
                    }
                }
            }
            self.collectionView.reloadData()
        })
        
        //# TODO: - Implement Multi-threading
        //Grabs profile Image
        CURRENT_USER_IMAGE.observeSingleEventOfType(.Value, withBlock: { snapshot in
            //set image to profile image for app
            if let snapshots = snapshot.children.allObjects as? [FDataSnapshot] {
                for snap in snapshots {
                    let img = Profile(profileImage:snap.value as! String)
                    let imgUrl:NSURL = NSURL(string: snap.value as! String)!
                    let request:NSURLRequest = NSURLRequest(URL: imgUrl)
                    let config = NSURLSessionConfiguration.defaultSessionConfiguration()
                    let session = NSURLSession(configuration: config)
                    let task = session.dataTaskWithRequest(request, completionHandler: {(data, response, error) in
                        self.profileImage.image = UIImage(data:data!)
                        self.imageBackground.image = UIImage(data:data!)
                    });
                    task.resume()
                    
                }
            }
        })
    }
    
    //# MARK: - iOS Methods
//    override func viewWillLayoutSubviews() {
//    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
      
        let userInfos = gallery[indexPath.row]
        if let cell = collectionView.dequeueReusableCellWithReuseIdentifier("ProfileCell", forIndexPath: indexPath) as? ProfileCell {
            
            var img:UIImage?
            if let Galleryimg = userInfos.imageGallery {
                //store the image and cache
                img = ProfileVC.imageCache.objectForKey(Galleryimg) as? UIImage
            }
            
            if isOneImage == true {
                img = ProfileVC.imageCache.objectForKey(oneImageGallery) as? UIImage
                //cell.ConfigureCell(userInfos, img:img)
            }
            cell.ConfigureCell(userInfos ,img:img)
            return cell
        } else {
            return ProfileCell()
        }
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//        return gallery.count
        return gallery.count
    }
    
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        return CGSizeMake(105, 105)
    }
    
    //# MARK: - Image Uploading
    @IBAction func CloseBtnPressed(sender: AnyObject) {
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    @IBAction func cameraBtn(sender:AnyObject) {
          presentViewController(imagePicker, animated: true, completion: nil)
    }
    
    /**
        Uploads images to the ImageShack & Firebase
        -Parameter image: Image the User selects
    */
    func imagePickerController(picker: UIImagePickerController, didFinishPickingImage image: UIImage, editingInfo: [String : AnyObject]?) {
        dismissViewControllerAnimated(true, completion: nil)
        let urlStr = "http://www.imageshack.us/upload_api.php"
        let url = NSURL(string: urlStr)!
        //convert image to jpg to make smaller
        let imgData = UIImageJPEGRepresentation(image, 0.2)!
        //require the string to be in data formate
        
        //firebase only excepts data
        let keyData = "137CGRSY28e678084d874adb604785f1a23628ad".dataUsingEncoding(NSUTF8StringEncoding)!
        let keyJSON = "json".dataUsingEncoding(NSUTF8StringEncoding)!
        
        //converts image to data to upload to Firebase
        Alamofire.upload(.POST, url, multipartFormData: { multipartFormData in
            //uses imageShack api to switch into data
            multipartFormData.appendBodyPart(data:imgData, name:"fileupload", fileName:"gallimages", mimeType:"image/jpg")
            multipartFormData.appendBodyPart(data:keyData,name:"key")
            multipartFormData.appendBodyPart(data: keyJSON, name: "format")
            
        }){ encodingResult in
            //once the request comes back
            switch encodingResult {
            case .Success(let upload, _, _):
        
                upload.responseJSON(completionHandler: { response in
                    if let info = response.result.value as? Dictionary<String, AnyObject> {
                        if let links = info["links"] as? Dictionary<String,AnyObject> {
                            if let imgLink = links["image_link"] as? String {
                                self.postToFirebase(imgLink)
                            }
                        }
                    }
                })
            case .Failure(let error):
                print(error)
            }
        }
        collectionView.reloadData()
    }
    
    /**
        Posts image URL to Firebase
        
        -Parameter imgUrl: The image URL from the ImageShack
    */
    func postToFirebase(imgUrl:String?) {
        let numberHolder = gallery.count + 1
        if imgUrl != nil {
            let upload: Dictionary<String,AnyObject> = [
                "image\(numberHolder)" : imgUrl!
            ]
            let firebasePost = DataService.ds.REF_USER_CURRENT.childByAppendingPath("imageGallery")
            print(upload)
            firebasePost.updateChildValues(upload)
            //print(firebasePost.childByAppendingPath("uid"))
            collectionView.reloadData()
        }
    }
}


//func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
//    return collectionView
//}



