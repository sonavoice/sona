//
//  LibraryViewController.swift
//  Vi
//
//  Created by Eugene Lee (colemakdvorak) on 10/21/15.
//  Copyright © 2015 Vi. All rights reserved.
//

import UIKit
import Alamofire

class LibraryViewController: UITableViewController {
  var apps:[App] = []
  var appInfo: App!
  @IBOutlet weak var menuButton: UIBarButtonItem!
  var burgerButton: HamburgerButton! = nil
  var addButton: AddExtButton! = nil
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    self.navigationController?.navigationBar.setBackgroundImage(UIImage(), forBarMetrics: UIBarMetrics.Default)
    self.navigationController?.navigationBar.shadowImage = UIImage()
    self.navigationController?.navigationBar.translucent = true
    self.navigationController?.view.backgroundColor = UIColor.clearColor()
    
    self.addButton = AddExtButton(frame: CGRectMake(0, 0, 40, 40))
    
    self.navigationItem.rightBarButtonItem = UIBarButtonItem(customView: addButton)
    self.addButton.addTarget(self, action: "moveToAddExtPage", forControlEvents: .TouchUpInside)
    
    if revealViewController() != nil {
      revealViewController().rearViewRevealWidth = 100
      
      self.burgerButton = HamburgerButton(frame: CGRectMake(0, 0, 40, 40))
      
      self.navigationItem.leftBarButtonItem = UIBarButtonItem(customView: burgerButton)
      
      self.burgerButton.addTarget(revealViewController(), action: "revealToggle:", forControlEvents: .TouchUpInside)
      
      view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
    }
  }
  
  override func viewDidAppear(animated: Bool) {
    self.apps.removeAll()
    self.loadApp()
  }
  
  func loadApp() {
    self.tableView.reloadData()
    let appMan = AppManager()
    let extensions = appMan.getAllExt()
    for ext in extensions {
      let name = ext.valueForKey("name")
      Alamofire.request(.GET, "https://sonavoice.com/extension", parameters: ["name": name as! String])
        .responseJSON { response in
          switch response.result {
          case .Success:
            if let JSON = response.result.value {
              let apps = JSON as! NSArray
              var newApps = [App]()
              for item in apps {
                if self.appCheck(item) {
                  let appName = item.valueForKey("name") as! String
                  let appDesc = item.valueForKey("description") as! String
                  let appComm = item.valueForKey("commands") as! [String]
                  let appIcon = item.valueForKey("iconURL") as! String
                  newApps.append(App(name: appName, description: appDesc, commands: appComm, iconURL: appIcon))
                }
              }
              self.apps += newApps
              self.tableView.reloadData()
            } else {
              
            }
          case .Failure:
            print("failed")
          }
      }
    }
  }
  
  func moveToAddExtPage() {
    self.performSegueWithIdentifier("showSearch", sender: self)
  }
  
  override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
    return 1
  }
  
  override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return self.apps.count
  }
  
  override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath)
    -> UITableViewCell {
      let cell = self.tableView.dequeueReusableCellWithIdentifier("CellView", forIndexPath: indexPath) as! CellView
      
      let appInfo = self.apps[indexPath.row] as App
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
      
      cell.layoutMargins = UIEdgeInsetsZero
      cell.preservesSuperviewLayoutMargins = false
      return cell
  }
  
  override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
    
    if (segue.identifier == "appSegue") {
      let path = self.tableView.indexPathForSelectedRow!
      let viewController = segue.destinationViewController as! AppInfoViewController
      viewController.appInfo = self.apps[path.indexAtPosition(1)]
    }
  }
  
  func appCheck(item:AnyObject) -> Bool {
    if item.valueForKey("name") != nil && item.valueForKey("description") != nil && item.valueForKey("commands") != nil && item.valueForKey("iconURL") as! String != "fake icon URL" {
      return true
    } else {
      return false
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
