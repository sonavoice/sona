//
//  LibraryViewController.swift
//  Vi
//
//  Created by Eugene Lee (colemakdvorak) on 10/21/15.
//  Copyright © 2015 Vi. All rights reserved.
//

import UIKit

class LibraryViewController: UITableViewController {
  var apps:[App]?
  var appInfo: App!
  @IBOutlet weak var menuButton: UIBarButtonItem!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    self.navigationController?.navigationBar.setBackgroundImage(UIImage(), forBarMetrics: UIBarMetrics.Default)
    self.navigationController?.navigationBar.shadowImage = UIImage()
    self.navigationController?.navigationBar.translucent = true
    self.navigationController?.view.backgroundColor = UIColor.clearColor()
    self.apps = dummyData
    
    if revealViewController() != nil {
      revealViewController().rearViewRevealWidth = 150
      menuButton.target = revealViewController()
      menuButton.action = "revealToggle:"
      
      //      revealViewController().rightViewRevealWidth = 150
      //      extraButton.target = revealViewController()
      //      extraButton.action = "rightRevealToggle:"
      
      view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
    }
    
    
    //// Color Declarations
    let primary = UIColor(red: 0.969, green: 0.149, blue: 0.243, alpha: 1.000)
    
    //// LIST_1_
    //// LIST
    //// Group 4
    //// Hamburger Drawing
    let hamburgerPath = UIBezierPath()
    hamburgerPath.moveToPoint(CGPointMake(3, 6))
    hamburgerPath.addLineToPoint(CGPointMake(61, 6))
    hamburgerPath.addCurveToPoint(CGPointMake(64, 3), controlPoint1: CGPointMake(62.66, 6), controlPoint2: CGPointMake(64, 4.66))
    hamburgerPath.addCurveToPoint(CGPointMake(61, 0), controlPoint1: CGPointMake(64, 1.34), controlPoint2: CGPointMake(62.66, 0))
    hamburgerPath.addLineToPoint(CGPointMake(3, 0))
    hamburgerPath.addCurveToPoint(CGPointMake(0, 3), controlPoint1: CGPointMake(1.34, 0), controlPoint2: CGPointMake(0, 1.34))
    hamburgerPath.addCurveToPoint(CGPointMake(3, 6), controlPoint1: CGPointMake(0, 4.66), controlPoint2: CGPointMake(1.34, 6))
    hamburgerPath.closePath()
    hamburgerPath.moveToPoint(CGPointMake(61, 16))
    hamburgerPath.addLineToPoint(CGPointMake(3, 16))
    hamburgerPath.addCurveToPoint(CGPointMake(0, 19), controlPoint1: CGPointMake(1.34, 16), controlPoint2: CGPointMake(0, 17.34))
    hamburgerPath.addCurveToPoint(CGPointMake(3, 22), controlPoint1: CGPointMake(0, 20.66), controlPoint2: CGPointMake(1.34, 22))
    hamburgerPath.addLineToPoint(CGPointMake(61, 22))
    hamburgerPath.addCurveToPoint(CGPointMake(64, 19), controlPoint1: CGPointMake(62.66, 22), controlPoint2: CGPointMake(64, 20.66))
    hamburgerPath.addCurveToPoint(CGPointMake(61, 16), controlPoint1: CGPointMake(64, 17.34), controlPoint2: CGPointMake(62.66, 16))
    hamburgerPath.closePath()
    hamburgerPath.moveToPoint(CGPointMake(61, 32))
    hamburgerPath.addLineToPoint(CGPointMake(3, 32))
    hamburgerPath.addCurveToPoint(CGPointMake(0, 35), controlPoint1: CGPointMake(1.34, 32), controlPoint2: CGPointMake(0, 33.34))
    hamburgerPath.addCurveToPoint(CGPointMake(3, 38), controlPoint1: CGPointMake(0, 36.66), controlPoint2: CGPointMake(1.34, 38))
    hamburgerPath.addLineToPoint(CGPointMake(61, 38))
    hamburgerPath.addCurveToPoint(CGPointMake(64, 35), controlPoint1: CGPointMake(62.66, 38), controlPoint2: CGPointMake(64, 36.66))
    hamburgerPath.addCurveToPoint(CGPointMake(61, 32), controlPoint1: CGPointMake(64, 33.34), controlPoint2: CGPointMake(62.66, 32))
    hamburgerPath.closePath()
    hamburgerPath.miterLimit = 4
    
    primary.setFill()
    hamburgerPath.fill()
    
    let hamburgerLayer = CAShapeLayer()
    hamburgerLayer.path = hamburgerPath.CGPath
//    menuButton.layoutSublayersOfLayer(hamburgerLayer)
  }
  
  override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
    return 1
  }
  
  override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return self.apps!.count
  }
  
  override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath)
    -> UITableViewCell {
      let cell = self.tableView.dequeueReusableCellWithIdentifier("CellView", forIndexPath: indexPath) as! CellView
      
      let appInfo = self.apps![indexPath.row] as App
      cell.name.font = UIFont(name: "Lato-Regular", size: 18)
      cell.name.textColor = UIColor(red: 33/255.0, green: 33/255.0, blue: 33/255.0, alpha: 1)
      cell.name.text = appInfo.name
      
//      let url = NSURL(string: appInfo.iconURL!)
//      let data = NSData(contentsOfURL: url!) //make sure your image in this url does exist, otherwise unwrap in a if let check
      
      cell.icon.image = UIImage(named: "image1")
      cell.icon.downloadImageFrom(link: appInfo.iconURL!, contentMode: UIViewContentMode.ScaleAspectFit)
      
      //set your image from link array.
//      
//      if data == nil {
//        cell.icon.image = UIImage(named: "image1")
//      } else {
//        cell.icon.image = UIImage(data: data!)
//      }
      cell.arrow.font = UIFont.fontAwesomeOfSize(30)
      cell.arrow.text = String.fontAwesomeIconWithCode("fa-angle-right")
      return cell
  }
  
  override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
    
    if (segue.identifier == "appSegue") {
      let path = self.tableView.indexPathForSelectedRow!
      let viewController = segue.destinationViewController as! AppInfoViewController
      viewController.appInfo = self.apps![path.indexAtPosition(1)]
    }
  }
}

extension UIImageView {
  func downloadImageFrom(link link:String, contentMode: UIViewContentMode) {
    NSURLSession.sharedSession().dataTaskWithURL( NSURL(string:link)!, completionHandler: {
      (data, response, error) -> Void in
      dispatch_async(dispatch_get_main_queue()) {
        self.contentMode =  contentMode
        if let data = data { self.image = UIImage(data: data) }
      }
    }).resume()
  }
}
