//
//  MessageVC.swift
//  designCode
// imageshack api key  137CGRSY28e678084d874adb604785f1a23628ad
// message image by artworkbean
//  Created by KENNETH GRANDBERRY on 3/30/16.
//  Copyright © 2016 KENNETH GRANDBERRY. All rights reserved.
//

import UIKit
import Alamofire

class PostVC: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    @IBOutlet weak var MessageVCprofileImage: UIImageView!
    @IBOutlet weak var UsermessageText: UITextView!
    @IBOutlet weak var cameraBtn: UIImageView!
    
    
    var customImages = CustomImages()
    var customTextView = CustomTextView()
    var imageselected = false
    var timelineVC = TimeLineVC()
    var imagePicker: UIImagePickerController!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
        customImages.circleImage(MessageVCprofileImage)
        customTextView.textViewCornerDesign(UsermessageText)
        imagePicker = UIImagePickerController()
        imagePicker.delegate = self
    }
    
    
    override func viewWillAppear(animated: Bool) {
       if self.revealViewController() != nil {
            self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
        }
    }
    
    @IBAction func SelectImage(sender: UITapGestureRecognizer) {
        presentViewController(imagePicker, animated: true, completion: nil)
    
    }
    
    @IBAction func CloseBtn(sender: AnyObject) {
        self.dismissViewControllerAnimated(true, completion: {})
        if (self.revealViewController() != nil) {
            self.revealViewController().revealToggleAnimated(true)
        }
    }
    
    
    @IBAction func PostBtn(sender: AnyObject) {
        //checks to insure the user enter in text
        if let txt = UsermessageText.text where txt != ""{
            //checks for image
            if let img = cameraBtn.image where imageselected == true {
                let urlStr = "http://www.imageshack.us/upload_api.php"
                let url = NSURL(string: urlStr)!
                //convert image to jpg to make smaller
                let imgData = UIImageJPEGRepresentation(img, 0.2)!
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
                                            self.postToFirebase(imgLink)
                                        }
                                    }
                                }
                            })
                        case .Failure(let error):
                            print(error)
                        }
                }
            } else {
                self.postToFirebase(nil)
                
            }
        }
    }
    
    //may not have an image url
    func postToFirebase(imgUrl:String?) {
        var post: Dictionary<String, AnyObject> = [
            "description" : UsermessageText.text!,
            "likes":0
            
        ]
        
        if imgUrl != nil {
            //imgUrl string is firebase key
            post["imageUrl"] = imgUrl!
        }
        
        let firebasePost = DataService.ds.REF_POST.childByAutoId()
        firebasePost.setValue(post)
        
        UsermessageText.text = ""
        cameraBtn.image = UIImage(named:"Camera")
        
        NSNotificationCenter.defaultCenter().postNotificationName("postsLoaded", object: nil)
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingImage image: UIImage, editingInfo: [String : AnyObject]?) {
        imagePicker.dismissViewControllerAnimated(true, completion: nil)
        cameraBtn.image = image
        imageselected = true
    }
    
    
}
