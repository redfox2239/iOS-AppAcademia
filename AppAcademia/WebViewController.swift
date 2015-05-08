//
//  WebViewController.swift
//  AppAcademia
//
//  Created by HARADA REO on 2015/05/03.
//  Copyright (c) 2015年 reoharada. All rights reserved.
//

import UIKit

class WebViewController: UIViewController {

    @IBOutlet weak var webView: UIWebView!
//    internal var name: String = "";
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        var urlString = "http://www.amazon.co.jp/gp/aw/d/B000FQP2YS/ref=mp_s_a_1_1?qid=1430620891&sr=8-1&pi=SY200_QL40&keywords=%E5%8C%96%E7%B2%A7%E5%93%81&dpPl=1&dpID=31mbv7WO30L&ref=plSrch";
        let url = NSURL(string: urlString);
        let request = NSURLRequest(URL: url!);
        self.webView.loadRequest(request);
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
