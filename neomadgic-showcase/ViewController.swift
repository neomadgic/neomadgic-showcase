//
//  ViewController.swift
//  neomadgic-showcase
//
//  Created by Vu Dang on 4/14/16.
//  Copyright © 2016 Vu Dang. All rights reserved.
//

import UIKit
import FBSDKCoreKit
import FBSDKLoginKit

class ViewController: UIViewController
{

    override func viewDidLoad()
    {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func facebookLoginPressed(sender: UIButton!)
    {
        let facebookLogin = FBSDKLoginManager()
        
        facebookLogin.logInWithReadPermissions(["email"], fromViewController: self)
            { (facebookResult: FBSDKLoginManagerLoginResult!, facebookError: NSError!) in
                
                if facebookError != nil
                    {
                        print("Facebook login failed. Error \(facebookError)")
                    }
                else
                    {
                        let accessToken = FBSDKAccessToken.currentAccessToken().tokenString
                        print("Successfully logged in with Facebook. \(accessToken)")
                    }
            }
    }

}

