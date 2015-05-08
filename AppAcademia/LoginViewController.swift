//
//  LoginViewController.swift
//  AppAcademia
//
//  Created by HARADA REO on 2015/05/08.
//  Copyright (c) 2015年 reoharada. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {

    @IBOutlet weak var userID: UITextField!
    @IBOutlet weak var password: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        NCMBUser.logOut();
        let defaults = NSUserDefaults.standardUserDefaults();
        defaults.setObject(nil, forKey: "userName");
        defaults.setObject(nil, forKey: "userLevel");
        defaults.synchronize();
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    @IBAction func loginButtonAction(sender: AnyObject) {
        // ユーザー名とパスワードでログイン
        var userId: String! = self.userID.text;
        var password: String! = self.password.text;
        NCMBUser.logInWithUsernameInBackground(userId, password: password) { (user:NCMBUser!, error:NSError!) -> Void in
            if(error == nil)
            {
                println("成功");
                self.performSegueWithIdentifier("loginFinish", sender: self);
            }
            else
            {
                println(error);
                println("失敗");
            }
        }
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
