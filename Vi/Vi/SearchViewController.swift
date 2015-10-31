//
//  PluginsViewController.swift
//  Vi
//
//  Created by Keith Armstrong on 10/22/15.
//  Copyright © 2015 Vi. All rights reserved.
//
import Alamofire
import UIKit

class SearchViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
  var apps = [App]()
  var appInfo: App!
  @IBOutlet weak var tableView: UITableView!
  
  override func viewDidLoad() {
    self.getApp()
  }
  
  func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return self.apps.count
  }
  
  func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath)
    -> UITableViewCell {
      let cell = tableView.dequeueReusableCellWithIdentifier("CellView", forIndexPath: indexPath) as! CellView
      
      let appInfo = self.apps[indexPath.row] as App
      cell.name.font = UIFont(name: "Lato-Regular", size: 18)
      cell.name.textColor = UIColor(red: 33/255.0, green: 33/255.0, blue: 33/255.0, alpha: 1)
      cell.name.text = appInfo.name
      
      let url = NSURL(string: appInfo.iconURL!)
      let data = NSData(contentsOfURL: url!) //make sure your image in this url does exist, otherwise unwrap in a if let check
      
      if data == nil {
        cell.icon.image = UIImage(named: "image1")
      } else {
        cell.icon.image = UIImage(data: data!)
      }
      cell.arrow.font = UIFont.fontAwesomeOfSize(30)
      cell.arrow.text = String.fontAwesomeIconWithCode("fa-angle-right")
      return cell
  }
  
  override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
    if (segue.identifier == "appSegue") {
      let path = self.tableView.indexPathForSelectedRow!
      self.tableView.deselectRowAtIndexPath(path, animated: true)
      let viewController = segue.destinationViewController as! AppInfoViewController
      viewController.appInfo = self.apps[path.indexAtPosition(1)]
    }
  }
  
  func getApp() {
    Alamofire.request(.GET, "http://viapi.io/extension", parameters: ["foo": "bar"])
      .responseJSON { response in
        switch response.result {
          case .Success:
            if let JSON = response.result.value {
              let apps = JSON as! NSArray
              for item in apps {
                if self.appCheck(item) {
                  let appName = item.valueForKey("name") as! String
                  let appDesc = item.valueForKey("description") as! String
                  let appComm = item.valueForKey("commands") as! [String]
                  let appIcon = item.valueForKey("iconURL") as! String
                  self.apps.append(App(name: appName, description: appDesc, commands: appComm, iconURL: appIcon))
                }
              }
              self.tableView.reloadData()
            } else {
              
            }
          case .Failure:
            print("failed")
        }
    }
  }
  
  func appCheck(item:AnyObject) -> Bool {
    if item.valueForKey("name") != nil && item.valueForKey("description") != nil && item.valueForKey("commands") != nil && item.valueForKey("iconURL") != nil {
      return true
    } else {
      return false
    }
  }

}
