//
//  InitialViewController.swift
//  AppAcademia
//
//  Created by HARADA REO on 2015/05/09.
//  Copyright (c) 2015年 reoharada. All rights reserved.
//

import UIKit

class InitialViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        NCMBUser.logOut();
        
        let defaults = NSUserDefaults.standardUserDefaults();
        if(defaults.objectForKey("userName") != nil &&
            defaults.objectForKey("password") != nil)
        {
            var userId = defaults.objectForKey("userName")! as? String;
            var password = defaults.objectForKey("password")! as? String;
            NCMBUser.logInWithUsernameInBackground(userId, password: password) { (user:NCMBUser!, error:NSError!) -> Void in
                if(error == nil)
                {
                    println("成功");
                    self.performSegueWithIdentifier("loginDid", sender: self);
                }
                else
                {
                    println(error);
                    println("失敗");
                }
            }
            
        }
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
