//
//  NavigatorViewController.swift
//  Vi
//
//  Created by Christopher Yung on 10/22/15.
//  Copyright © 2015 Vi. All rights reserved.
//

import UIKit
import FontAwesome_swift

class NavigatorViewController: UIViewController {

  @IBOutlet weak var settingsButton: UIButton!
  @IBOutlet weak var searchButton: UIButton!
  @IBOutlet weak var libraryButton: UIButton!
  @IBOutlet weak var homeButton: UIButton!
  @IBOutlet weak var containerView: UIView!
  weak var currentViewController: UIViewController?
  
  override func viewDidLoad() {
    self.currentViewController = self.storyboard?.instantiateViewControllerWithIdentifier("homeComponent")
    self.currentViewController!.view.translatesAutoresizingMaskIntoConstraints = false
    self.addChildViewController(self.currentViewController!)
    self.addSubview(self.currentViewController!.view, toView: self.containerView)
    
    
    homeButton.titleLabel?.font = UIFont.fontAwesomeOfSize(28)
    homeButton.setTitle(String.fontAwesomeIconWithCode("fa-home"), forState: .Normal)
    libraryButton.titleLabel?.font = UIFont.fontAwesomeOfSize(28)
    libraryButton.setTitle(String.fontAwesomeIconWithCode("fa-book"), forState: .Normal)
    searchButton.titleLabel?.font = UIFont.fontAwesomeOfSize(28)
    searchButton.setTitle(String.fontAwesomeIconWithCode("fa-search"), forState: .Normal)
    settingsButton.titleLabel?.font = UIFont.fontAwesomeOfSize(28)
    settingsButton.setTitle(String.fontAwesomeIconWithCode("fa-cog"), forState: .Normal)
    super.viewDidLoad()
  }

  override func didReceiveMemoryWarning() {
      super.didReceiveMemoryWarning()
      // Dispose of any resources that can be recreated.
  }
  
  func addSubview(subView:UIView, toView parentView:UIView) {
    parentView.addSubview(subView)
    
    var viewBindingsDict = [String: AnyObject]()
    viewBindingsDict["subView"] = subView
    parentView.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:|[subView]|",
      options: [], metrics: nil, views: viewBindingsDict))
    parentView.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("V:|[subView]|",
      options: [], metrics: nil, views: viewBindingsDict))
  }
    
  @IBAction func changeToHome() {
    changeTab("homeComponent")
  }

  @IBAction func changeToLibrary() {
    changeTab("libraryComponent")
  }
  @IBAction func changeToPlugins() {
    changeTab("searchComponent")
  }
  @IBAction func changeToSettings() {
    changeTab("settingsComponent")
  }
  
  func cycleFromViewController(oldViewController: UIViewController, toViewController newViewController: UIViewController) {
    oldViewController.willMoveToParentViewController(nil)
    self.addChildViewController(newViewController)
    self.addSubview(newViewController.view, toView:self.containerView!)
    newViewController.view.alpha = 0
    newViewController.view.layoutIfNeeded()
    UIView.animateWithDuration(0.0, animations: {
      newViewController.view.alpha = 1
      oldViewController.view.alpha = 1
      },
      completion: { finished in
        oldViewController.view.removeFromSuperview()
        oldViewController.removeFromParentViewController()
        newViewController.didMoveToParentViewController(self)
    })
  }
  
  func changeTab(tabName: String) {
    let newViewController = self.storyboard?.instantiateViewControllerWithIdentifier(tabName)
    newViewController!.view.translatesAutoresizingMaskIntoConstraints = false
    self.cycleFromViewController(self.currentViewController!, toViewController: newViewController!)
    self.currentViewController = newViewController
  }


}
