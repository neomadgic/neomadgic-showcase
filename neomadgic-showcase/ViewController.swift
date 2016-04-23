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

    @IBOutlet weak var emailField: MaterialText!
    @IBOutlet weak var passwordField: MaterialText!
    
    
    
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func viewDidAppear(animated: Bool)
    {
        super.viewDidAppear(animated)
        
        if NSUserDefaults.standardUserDefaults().valueForKey(KEY_UID) != nil
            {
                self.performSegueWithIdentifier(SEGUE_LOGGED_IN, sender: nil)
            }
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
                        
                        DataService.ds.REF_BASE.authWithOAuthProvider("facebook", token: accessToken, withCompletionBlock:
                            { (error, authData) in
                            
                                if error != nil
                                    {
                                        print("Login failed. \(error)")
                                    }
                                else
                                    {
                                        print("Logged in!! \(authData)")
                                        
                                        let user = ["provider": authData.provider!]
                                        DataService.ds.createFirebaseUser(authData.uid, user: user)
                                        NSUserDefaults.standardUserDefaults().setValue(authData.uid, forKey: KEY_UID)
                                        self.performSegueWithIdentifier(SEGUE_LOGGED_IN, sender: nil)
                                    }
                            })
                    }
            }
    }
    
    @IBAction func attemptLogin(sender: UIButton!)
    {
        if let email = emailField.text where email != "", let pwd = passwordField.text where pwd != ""
            {
                DataService.ds.REF_BASE.authUser(email, password: pwd, withCompletionBlock:
                    { (error, authData) in
                        
                        if error != nil
                            {
                                print(error)
                                
                                if error.code == STATUS_ACCOUNT_NONEXIST
                                    {
                                        
                                        DataService.ds.REF_BASE.createUser(email, password: pwd, withValueCompletionBlock:
                                            { error, result in
                                                
                                                if error != nil
                                                    {
                                                        self.showErrorAlert("Could not create User", msg: "Please try again")
                                                    }
                                                else
                                                    {
                                                        NSUserDefaults.standardUserDefaults().setValue(result[KEY_UID], forKey: KEY_UID)
                                                        DataService.ds.REF_BASE.authUser(email, password: pwd, withCompletionBlock:
                                                            { (err, authData) in
                                                                let user = ["provider": authData.provider!, "username": self.emailField.text!]
                                                                DataService.ds.createFirebaseUser(authData.uid, user: user)
                                                            })
                                                        self.performSegueWithIdentifier(SEGUE_LOGGED_IN, sender: nil)
                                                    }
                                                
                                            })
                                    }
                                else if error.code == STATUS_ACCOUNT_INVALID_EMAIL
                                    {
                                        self.showErrorAlert("Invalid Email", msg: "You have entered an invalid email")
                                    }
                                else if error.code == STATUS_ACCOUNT_WRONG_PASSWORD
                                    {
                                        self.showErrorAlert("Wrong Password", msg: "You entered the wrong password, try again")
                                    }
                                else
                                    {
                                        self.showErrorAlert("Something went wrong", msg: "Please check to see what went wrong")
                                    }
                            }
                        else
                            {
                                self.performSegueWithIdentifier(SEGUE_LOGGED_IN, sender: nil)
                            }
                        
                    })
            }
        else
            {
                showErrorAlert("Email and Password Required", msg: "You must enter both an email and password.")
            }
    }
    
    func showErrorAlert(title: String, msg: String)
    {
        let alert = UIAlertController(title: title, message: msg, preferredStyle: .Alert)
        let action = UIAlertAction(title: "Ok", style: .Default, handler: nil)
        
        alert.addAction(action)
        presentViewController(alert, animated: true, completion: nil)
        
    }
    
    
    

}

