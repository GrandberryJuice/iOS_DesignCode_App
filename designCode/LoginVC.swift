//
//  ViewController.swift
//  designCode
//
//  Created by KENNETH GRANDBERRY on 3/18/16.
//  Copyright © 2016 KENNETH GRANDBERRY. All rights reserved.
//

import UIKit
import pop
import FBSDKCoreKit
import FBSDKLoginKit

class LoginVC: UIViewController {
    
    @IBOutlet weak var emailField:UITextField!
    @IBOutlet weak var passwordField:UITextField!
    @IBOutlet weak var LoginInBtn:UIButton!
    
    
    //Constraints
    @IBOutlet weak var loginBtnConstraint: NSLayoutConstraint!
    @IBOutlet weak var emailConstraint: NSLayoutConstraint!
    @IBOutlet weak var passwordConstraint: NSLayoutConstraint!
    
    var animEngine: AnimationEngine!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.animEngine = AnimationEngine(constraints: [emailConstraint,passwordConstraint,loginBtnConstraint])
    }
    
    override func viewDidAppear(animated: Bool) {
        self.animEngine.animateOnScreen(1)
        
        //automatically take user to first screen if logged in
        if NSUserDefaults.standardUserDefaults().valueForKey(KEY_UID) != nil {
            self.performSegueWithIdentifier(SEGUE_LOGGED_IN, sender: nil)
        }
        
    }
    
    @IBAction func fbBtnPressed(sender:UIButton) {
        // facebook login
        let facebookLogin = FBSDKLoginManager()
        
        facebookLogin.logInWithReadPermissions(["email"]) { (facebookResult: FBSDKLoginManagerLoginResult!,facebookError: NSError!) -> Void in
            
            if facebookError != nil {
                print("Facebook login failed. Error \(facebookError)")
            
            } else {
                let accessToken = FBSDKAccessToken.currentAccessToken().tokenString
                print("Successfully logged in with facebook. \(accessToken)")
                
                //set up for user login to save user
                DataService.ds.REF_BASE.authWithOAuthProvider("facebook", token: accessToken, withCompletionBlock: {
                error, authData in
                    
                    //finish error handle if user is not able to login
                    if error != nil {
                        print("Login Failed")
                    } else {
                        print("Logged In! \(authData)")
                        
                        //save user to device
                        NSUserDefaults.standardUserDefaults().setValue(authData.uid, forKey: KEY_UID)
                        self.performSegueWithIdentifier(SEGUE_LOGGED_IN, sender: nil)
                    }
                    
                })
            }
        }
    }
    
    @IBAction func attemptLogin(sender:UIButton) {
        if let email = emailField.text where email != "", let pwd = passwordField.text where pwd != "" {
            
            //connecting to firebase
            DataService.ds.REF_BASE.authUser(email, password:pwd, withCompletionBlock: { error, authData in
                    
                    if error != nil {
                        //create a new user
                        if error.code == STATUS_ACCOUNT_NONEXIST {
                            DataService.ds.REF_BASE.createUser(email, password: pwd, withValueCompletionBlock: { error , result in
                                if error != nil {
                                    self.showErrorAlert("Could not create account", msg: "Problem creating account. Try something else")
                                    
                                } else {
                                    //if logged in save account and log in
                                    NSUserDefaults.standardUserDefaults().setValue(result[KEY_UID], forKey: KEY_UID)
                                    DataService.ds.REF_BASE.authUser(email, password: pwd, withCompletionBlock: nil)
                                        self.performSegueWithIdentifier(SEGUE_LOGGED_IN, sender: nil)
                                }
                            })
                        } else {
                            //other errors
                            self.showErrorAlert("Could not log in", msg: "Plese check your username or password")
                            
                        }
                        
                        //print(error)
                    } else {
                        //if user try to log in and there is no error
                        self.performSegueWithIdentifier(SEGUE_LOGGED_IN, sender: nil)
                    }
                    
            })
            
        } else {
            // if user does not enter in anything
            showErrorAlert("Email and Password Required", msg: "You must enter an email and Password")
        
        }
    
    }
    
    func showErrorAlert(title:String,msg:String) {
        let alert = UIAlertController(title: title, message: msg, preferredStyle: .Alert)
        let action = UIAlertAction(title: "OK", style: .Default, handler: nil)
        alert.addAction(action)
        presentViewController(alert, animated: true, completion: nil)
    }

}


/***
//Standard UIAnnimation -just in case
//    override func viewDidAppear(animated: Bool) {
//        UIView.animateWithDuration(6) { () -> Void in
//            self.emailConstraint.constant = -100
//            self.view.layoutIfNeeded()
//        }
//    }
***/