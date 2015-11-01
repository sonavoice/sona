//
//  SigninViewController.swift
//  Vi
//
//  Created by Qwerty on 10/29/15.
//  Copyright © 2015 Vi. All rights reserved.
//

import UIKit

class SigninViewController: UIViewController, UIWebViewDelegate {
  var appname: String = ""
  let appManager = AppManager()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    let button   = UIButton(type: UIButtonType.System) as UIButton
    button.frame = CGRectMake(100, 100, 100, 50)
    button.backgroundColor = UIColor.greenColor()
    button.setTitle("Test Button", forState: UIControlState.Normal)
    button.addTarget(self, action: "closeWebView:", forControlEvents: UIControlEvents.TouchUpInside)
    
    let webView:UIWebView = UIWebView(frame: CGRectMake(0, 0, UIScreen.mainScreen().bounds.width, UIScreen.mainScreen().bounds.height))
    
    let address = "http://localhost:3000/authenticate/" + self.appname
    //let address = "https://slack.com/signin"
    webView.loadRequest(NSURLRequest(URL: NSURL(string: address)!))
    
    self.view.addSubview(webView)
    self.view.addSubview(button)
  }
  
  func closeWebView(sender: UIButton!) {
    var num = 0
    for subview in self.view.subviews {
      if(num == 0) {
        let subview = subview as! UIWebView
        let html = subview.stringByEvaluatingJavaScriptFromString("document.body.innerHTML")
        appManager.saveToken(self.appname, tokenToSave: html!)
      }
      num = num + 1
    }
    self.dismissViewControllerAnimated(true, completion: nil)
  }
}