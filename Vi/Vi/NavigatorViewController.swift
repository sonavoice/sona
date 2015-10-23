//
//  NavigatorViewController.swift
//  Vi
//
//  Created by Christopher Yung on 10/22/15.
//  Copyright © 2015 Vi. All rights reserved.
//

import UIKit

class NavigatorViewController: UIViewController {

  @IBOutlet weak var containerView: UIView!
  weak var currentViewController: UIViewController?
  
  override func viewDidLoad() {
    self.currentViewController = self.storyboard?.instantiateViewControllerWithIdentifier("homeComponent")
    self.currentViewController!.view.translatesAutoresizingMaskIntoConstraints = false
    self.addChildViewController(self.currentViewController!)
    self.addSubview(self.currentViewController!.view, toView: self.containerView)
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
    changeTab("pluginsComponent")
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
    UIView.animateWithDuration(0.5, animations: {
      newViewController.view.alpha = 1
      oldViewController.view.alpha = 0
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
