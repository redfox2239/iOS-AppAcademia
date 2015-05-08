//
//  ViewController.swift
//  AppAcademia
//
//  Created by HARADA REO on 2015/05/02.
//  Copyright (c) 2015年 reoharada. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var userID: UITextField!
    @IBOutlet weak var password: UITextField!
    @IBOutlet weak var mail: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func viewDidAppear(animated: Bool) {
        println("表示されました");
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func postUserInfo(sender: AnyObject) {
        var userInfo = NCMBUser();
        userInfo.userName = self.userID.text;
        userInfo.password = self.password.text;
        userInfo.mailAddress = self.mail.text;
        userInfo.setObject("device", forKey: "iPhone");
        
        userInfo.signUpInBackgroundWithBlock{(error:NSError!)->Void in
            if (error == nil){
                println("Sign up succeeded!");
                self.setUserLevel(userInfo.userName);
                self.performSegueWithIdentifier("registFinish", sender:self);
            }
            else
            {
                print(error);
                println("error")
            }
        }
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject!) {
        if (segue.identifier == "registFinish") {
            // SecondViewControllerクラスをインスタンス化してsegue（画面遷移）で値を渡せるようにバンドルする
            //var secondView : LoginFinishViewController = segue.destinationViewController as LoginFinishViewController;
            var secondView: RegistFinishViewController = segue.destinationViewController as! RegistFinishViewController;
            secondView.hoge = "wa-i";
//            secondView.hoge = "hoge";
            // secondView（バンドルされた変数）に受け取り用の変数を引数とし_paramを渡す（_paramには渡したい値）
            // この時SecondViewControllerにて受け取る同型の変数を用意しておかないとエラーになる
        }
    }
    
    func setUserLevel(userName: String){
        var userInfo = NCMBObject(className: "userInfo");
        userInfo.setObject(userName, forKey: "userName");
        userInfo.setObject("1", forKey: "userLevel");
        userInfo.saveInBackgroundWithBlock(nil);
    }
}

