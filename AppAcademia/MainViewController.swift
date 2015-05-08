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
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(animated: Bool) {
        var currentUser = NCMBUser.currentUser();
        if((currentUser) != nil)
        {
            self.userNameLabel.text = currentUser.userName;
        }
        else
        {
            self.userNameLabel.text = "";
        }
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
