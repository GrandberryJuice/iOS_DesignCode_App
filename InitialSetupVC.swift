//
//  InitialSetupVC.swift
//  designCode
//
//  Created by KENNETH GRANDBERRY on 4/24/16.
//  Copyright © 2016 KENNETH GRANDBERRY. All rights reserved.
//

import UIKit
import Alamofire

class InitialSetupVC: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    @IBOutlet weak var profileImage:UIImageView!
    @IBOutlet weak var usernameTextField:UITextField!
    @IBOutlet weak var careerTextField:UITextField!
    
    var customImages = CustomImages()
    var imagePicker:UIImagePickerController!
    var imageselected = false
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        customImages.circleImage(profileImage)
        imagePicker = UIImagePickerController()
        imagePicker.delegate = self
       
    }
    
    @IBAction func ProfilePicPressed(sender: AnyObject) {
        presentViewController(imagePicker, animated: true, completion: nil)
    
    }
    
    //Need to be refactored later with PostVC
    @IBAction func setupCompletePressed(sender: AnyObject) {
        if profileImage != nil && usernameTextField != nil && careerTextField != nil {
            let username = usernameTextField.text!
            let imgApi = profileImage.image!
          
            //let userInfo = UserInfo(username: username, image: img!)
            
            //image setup sink to imageshack
            let urlStr = "http://www.imageshack.us/upload_api.php"
            let url = NSURL(string: urlStr)!
            
            //convert image to jpg to make smaller
            let imgData = UIImageJPEGRepresentation(imgApi, 0.2)!
            
            //require the string to be in data formate
            //firebase only excepts data
            let keyData = "137CGRSY28e678084d874adb604785f1a23628ad".dataUsingEncoding(NSUTF8StringEncoding)!
            let keyJSON = "json".dataUsingEncoding(NSUTF8StringEncoding)!
            
            //converts image to data to upload to Firebase
            Alamofire.upload(.POST, url, multipartFormData: {multipartFormData in
                //uses imageShack api to switch into data
                multipartFormData.appendBodyPart(data:imgData, name:"fileupload", fileName:"image", mimeType:"image/jpg")
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
                                    //print("Link:\(imgLink)")
                                    self.postProfileImageToFirebase(imgLink,username: username)
                                }
                            }
                        }
                    })
                case .Failure(let error):
                    print(error)
                }
            }
        }
    }
    
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingImage image: UIImage, editingInfo: [String : AnyObject]?) {
        imagePicker.dismissViewControllerAnimated(true, completion: nil)
        profileImage.image = image
        imageselected = true
    }
    
    
    //Parts to be refactored with PostVC
    func postProfileImageToFirebase(imgUrl:String?, username:String) {
        var setup: Dictionary<String,AnyObject> = [
             "username":usernameTextField.text!
        
        ]
        //not sure if correct
        
        
        if imgUrl != nil {
            //imgUrl string is firebase key
            setup["imageUrl"] = imgUrl!
            //not sure if its correct!
            
        }
        let firebaseUserImage = DataService.ds.REF_USERINFO.childByAutoId()
        firebaseUserImage.setValue(setup)
       
        //Go to TimelineVC
         self.performSegueWithIdentifier(SEGUE_LOGGED_IN, sender: nil)
  
    }
    
    /*
     Future Notes for connecting friends user gesture click to grab the username
     reference username with userInfo and connect to posts to insure the correct user
     ****may not needed
     
     Once arriving it should load that user profile image label info
     and should also and collection of images the user has uploaded!!!!
     
     
     user name should also really be in users to reference back to userInfo
     and user uploads should ref the posts imgurls
     
     
    */


}
