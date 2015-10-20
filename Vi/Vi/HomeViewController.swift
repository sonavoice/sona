//
//  HomeViewController.swift
//  Vi
//
//  Created by Eugene Lee (colemakdvorak) 10/20/15.
//  Copyright © 2015 Vi. All rights reserved.
//
import UIKit

class HomeViewController: UIViewController {
  
  override func viewDidLoad() {
    super.viewDidLoad()
    createButton()
  }
  
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    
  }
  
  func createButton () {
    let button = UIButton();
    button.setTitle("Vi", forState: .Normal)
    button.setTitleColor(UIColor.blueColor(), forState: .Normal)
    button.frame = CGRectMake(200, 65, 46, 30) // X, Y, width, height
    button.addTarget(self, action: "buttonPressed:", forControlEvents: .TouchUpInside)
    self.view.addSubview(button)
  }
  
  func buttonPressed(sender: UIButton!) {
    let alertView = UIAlertView();
    alertView.addButtonWithTitle("Done");
    alertView.title = "Alert!";
    alertView.message = "Button Pressed!!!";
    alertView.show();
  }
}