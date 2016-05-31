//
//  SignUpViewController.swift
//  Ober
//
//  Created by administrator on 5/29/16.
//  Copyright © 2016 administrator. All rights reserved.
//

import UIKit
import Parse

class SignUpViewController: UIViewController {
    
    
    @IBOutlet weak var username: UITextField!
    @IBOutlet weak var password: UITextField!
    
    @IBOutlet weak var riderDriverControl: UISegmentedControl!
    
    var buttonTitlePressed: String?
    var isSignIn: Bool!
    var isRider: Bool!

    override func viewDidLoad() {
        super.viewDidLoad()

        self.determineSignInOrRegister()
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    @IBAction func cancel(sender: AnyObject) {
        
        self.dismissViewControllerAnimated(true, completion: nil)
        
    }
    
    @IBAction func done(sender: AnyObject) {
        
        if isSignIn == false {
            
            //Register code Checks
            
            if self.username.text == "" || self.password.text == "" || self.riderDriverControl.selectedSegmentIndex == -1 {
                
                if self.username.text == "" {
                    
                    self.username.layer.borderColor = UIColor.redColor().CGColor
                    self.username.layer.borderWidth = 1.0
                    
                }
                
                if self.password.text == "" {
                    
                    self.password.layer.borderColor = UIColor.redColor().CGColor
                    self.password.layer.borderWidth = 1.0
                    
                }
                
                if self.riderDriverControl.selectedSegmentIndex == -1 {
                    
                    self.riderDriverControl.layer.borderColor = UIColor.redColor().CGColor
                    self.riderDriverControl.layer.borderWidth = 1.0
                    
                    self.showAlert("Missing Field Required", message: "Fill in or select missing Field(s) in red")
                    
                }
                    
                
                
            }else{
                
                var user =  PFUser()
                user.username = self.username.text
                user.password = self.password.text
                
                user["isRider"] = self.isRider
                
                user.signUpInBackgroundWithBlock {
                    (succeeded: Bool, error: NSError?) -> Void in
                    if let error = error {
                        
                        let errorString = error.userInfo["error"] as? NSString
                        
                        self.showAlert("Error Registering", message: String(errorString))
                        
                    } else {
                        
                        print("Register Succedded")
                        self.showAlert("Succedded", message: "Register Succedded")
                        
                    }
                }
                
            }
            
        }else{
            
            //Sign In code
            
            PFUser.logInWithUsernameInBackground(self.username.text!, password:self.password.text!) {
                (user: PFUser?, error: NSError?) -> Void in
                if user != nil {
                    
                    self.showAlert("Success", message: "Login Successful")
                    
                } else {
                    
                    if let errorINfo = error?.userInfo["error"] as? String{
                        
                        self.showAlert("Sign Up Failed", message: errorINfo)
                        
                    }
                    
                    
                }
            }

            
        }
        
    }
    
    func  determineSignInOrRegister(){
        
        if buttonTitlePressed != nil{
            
            if buttonTitlePressed == "Sign In" {
                
                isSignIn = true
                
                self.navigationController?.topViewController!.title = "Sign In"
                
                print(isSignIn)
                
            }else{
                
                isSignIn = false
                
                self.navigationController!.topViewController!.title = "Register"
                
                self.riderDriverControl.hidden = false
                
                
                print("Register")
                
                print(isSignIn)
                
            }
            
        }
    }
    
    @IBAction func riderDriver(sender: UISegmentedControl) {
        
        if self.riderDriverControl.selectedSegmentIndex == 0 {
            
            self.isRider = true
            
            print("I'm a rider")
            print(isRider)
            
        }else{
            
            self.isRider = false
            
            print(isRider)
            
        }
        
    }
    
    func showAlert(title: String, message: String){
        
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertControllerStyle.Alert)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler: nil))
        self.presentViewController(alert, animated: true, completion: nil)
        
    }
    

}
