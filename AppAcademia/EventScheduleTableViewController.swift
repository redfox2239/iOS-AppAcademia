//
//  EventScheduleTableViewController.swift
//  AppAcademia
//
//  Created by HARADA REO on 2015/05/09.
//  Copyright (c) 2015年 reoharada. All rights reserved.
//

import UIKit

class EventScheduleTableViewController: UITableViewController, UITableViewDelegate, UITableViewDataSource {

    var eventData: [NSDictionary] = [];
    @IBOutlet weak var userNameLabel: UILabel!
    @IBOutlet weak var userLevelLabel: UILabel!
    @IBOutlet weak var loginButton: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()

        self.tableView.delegate = self;
        self.tableView.dataSource = self;
        
        //カスタムセルを指定
        var nib  = UINib(nibName: "EventTableViewCell", bundle:nil)
        self.tableView.registerNib(nib, forCellReuseIdentifier:"EventTableViewCell")

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
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
            self.eventData.removeAll(keepCapacity: true);
            self.loginButton.setTitle("ログイン", forState: UIControlState.Normal);
            
            self.tableView.reloadData();
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Potentially incomplete method implementation.
        // Return the number of sections.
        return 1;
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete method implementation.
        // Return the number of rows in the section.
        return self.eventData.count;
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("EventTableViewCell", forIndexPath: indexPath) as! EventTableViewCell
        if(self.eventData.count > 0)
        {
            let event = self.eventData[indexPath.row];
            cell.eventNameLabel.text = event.objectForKey("eventName") as? String;
            var date = event.objectForKey("date") as? String;
            var startTime = event.objectForKey("startTime") as? String;
            var endTime = event.objectForKey("endTime") as? String;
            cell.dateLabel.text = "\(date!)  \(startTime!)〜\(endTime!)";
            cell.placeLabel.text = event.objectForKey("place") as? String;
        }
        return cell
    }

    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 100;
    }
    
    func getEventFromLevel(userLevel: String) {
        var query = NCMBQuery(className: "event");
        query.whereKey("targetLevel", equalTo: userLevel);
        query.findObjectsInBackgroundWithBlock { (values, error) -> Void in
            for val in values
            {
                var eventDataDic: Dictionary! = ["eventName":val.objectForKey("eventName")!,
                                                "date":val.objectForKey("date")!,
                                                "startTime":val.objectForKey("startTime")!,
                                                "endTime":val.objectForKey("endTime")!,
                                                "place":val.objectForKey("place")!];
                self.eventData.append(eventDataDic);
                self.tableView.reloadData();
            }
        }
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
                self.getEventFromLevel(userLevel!);
                let defaults = NSUserDefaults.standardUserDefaults();
                defaults.setObject(userName, forKey: "userName");
                defaults.setObject(userLevel!, forKey: "userLevel");
                defaults.synchronize();
            }
        }
    }
    
    /*
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return NO if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            // Delete the row from the data source
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return NO if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.
    }
    */

}
