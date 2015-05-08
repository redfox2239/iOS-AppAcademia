//
//  MainViewController.swift
//  AppAcademia
//
//  Created by HARADA REO on 2015/05/08.
//  Copyright (c) 2015年 reoharada. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {

    @IBOutlet weak var userNameLabel: UILabel!
    @IBOutlet weak var userLevelLabel: UILabel!
    @IBOutlet weak var loginButton: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(animated: Bool) {
        var currentUser = NCMBUser.currentUser();
        if((currentUser) != nil)
        {
            self.userNameLabel.text = currentUser.userName;
            self.getUserLevel(currentUser.userName);
            self.loginButton.setTitle("ログアウト", forState: UIControlState.Normal);
        }
        else
        {
            self.userNameLabel.text = "";
            self.userLevelLabel.text = "";
            self.loginButton.setTitle("ログイン", forState: UIControlState.Normal);
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func getUserLevel(userName: String) {
        var query = NCMBQuery(className: "userInfo");
        query.whereKey("userName", equalTo: userName);
        query.findObjectsInBackgroundWithBlock { (values, error) -> Void in
            for val in values
            {
                var userLevel = val.objectForKey("userLevel") as? String;
                self.userLevelLabel.text = "レベル\(userLevel!)";
                self.userLevelLabel.sizeToFit();
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
