//
//  ViewController.swift
//  Ober
//
//  Created by administrator on 5/14/16.
//  Copyright © 2016 administrator. All rights reserved.
//

import UIKit
import Parse
import AVKit
import AVFoundation


class ViewController: UIViewController {

    @IBOutlet var videoView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setupView()
        
        /*let testObject = PFObject(className: "TestObject")
        testObject["foo"] = "bar"
        testObject.saveInBackgroundWithBlock { (success: Bool, error: NSError?) -> Void in
            print("Object has been saved.")
        }*/
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func setupView(){
        
        let path = NSURL(fileURLWithPath: NSBundle.mainBundle().pathForResource("Traffic-blurred2", ofType: "mp4")!)
        
        let player = AVPlayer(URL: path)
        
        let newLayer = AVPlayerLayer(player: player)
        newLayer.frame = self.videoView.frame
        self.videoView.layer.addSublayer(newLayer)
        newLayer.videoGravity = AVLayerVideoGravityResizeAspectFill
        self.oberTextCenter(self.videoView)
        player.play()
        player.actionAtItemEnd = AVPlayerActionAtItemEnd.None
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(ViewController.videoDidPlayToEnd(_:)), name: "AVPlayerItemDidPlayToEndTimeNotification", object: player.currentItem)
        
        self.createOberButtons(self.videoView)
        
        
        
    }
    
    
    
    
    func videoDidPlayToEnd(notification: NSNotification){
        
        let player: AVPlayerItem = notification.object as! AVPlayerItem
        player.seekToTime(kCMTimeZero)
        
    }
    
    func oberTextCenter(containerView: UIView){
        
        let half:CGFloat = 1.0 / 2.0
        
        let oberLabel = UILabel()
        oberLabel.text = ""
        oberLabel.font = UIFont(name: "Apple Color Emoji", size: 120.0)
        oberLabel.backgroundColor = UIColor.clearColor()
        oberLabel.textColor = UIColor.whiteColor()
        oberLabel.sizeToFit()
        oberLabel.textAlignment = NSTextAlignment.Center
        oberLabel.frame.origin.x = (containerView.frame.size.width - oberLabel.frame.size.width) * half
        oberLabel.frame.origin.y = (containerView.frame.size.height - oberLabel.frame.size.height) * half
        containerView.addSubview(oberLabel)
        
    }
    
    func createOberButtons(containerView: UIView){
        let margin:CGFloat =  15.0
        let middleSpacing:CGFloat = 7.5
        
        let signIn = UIButton()
        signIn.setTitle("Sign In", forState: .Normal)
        signIn.setTitleColor(UIColor.blackColor(), forState: .Normal)
        signIn.backgroundColor = UIColor.greenColor()
        signIn.frame.size.width = (((containerView.frame.size.width - signIn.frame.size.width) - (margin * 2)) / 2 - middleSpacing)
        signIn.frame.size.height = 40.0
        signIn.frame.origin.x = margin
        signIn.frame.origin.y = ((containerView.frame.size.height - signIn.frame.size.height) - 25)
        signIn.addTarget(self, action: Selector("signInButtonPressed:"), forControlEvents: UIControlEvents.TouchUpInside)
        containerView.addSubview(signIn)
        
        let register = UIButton()
        register.setTitle("Register", forState: .Normal)
        register.setTitleColor(UIColor.blackColor(), forState: .Normal)
        register.backgroundColor = UIColor.greenColor()
        register.frame.size.width = (((containerView.frame.size.width - register.frame.size.width) - (margin * 2)) / 2 - middleSpacing)
        register.frame.size.height = 40.0
        register.frame.origin.x = ((containerView.frame.size.width - register.frame.size.width) - margin)
        register.frame.origin.y = ((containerView.frame.size.height - register.frame.size.height) - 25)
        register.addTarget(self, action: "registerButtonPressed:", forControlEvents: UIControlEvents.TouchUpInside)
        containerView.addSubview(register)
        
        
        
    }
    
    func signInButtonPressed(sender: UIButton!){
        
        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let signUpVC:SignUpViewController = storyBoard.instantiateViewControllerWithIdentifier("signUp") as! SignUpViewController
        signUpVC.buttonTitlePressed = sender.titleLabel?.text
        
        let navigationController = UINavigationController(rootViewController: signUpVC)
        
        self.presentViewController(navigationController, animated: true, completion: nil)
        
        
    }
    
    func registerButtonPressed(sender: UIButton!){
        
        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let signUpVC:SignUpViewController = storyBoard.instantiateViewControllerWithIdentifier("signUp") as! SignUpViewController
        signUpVC.buttonTitlePressed = sender.titleLabel?.text
        
        let navigationController = UINavigationController(rootViewController: signUpVC)
        
        self.presentViewController(navigationController, animated: true, completion: nil)
        
    }

}

