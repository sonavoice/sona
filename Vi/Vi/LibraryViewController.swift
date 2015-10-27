//
//  LibraryViewController.swift
//  Vi
//
//  Created by Eugene Lee (colemakdvorak) on 10/21/15.
//  Copyright © 2015 Vi. All rights reserved.
//

import UIKit

class LibraryViewController: UITableViewController {
  var apps = dummyData
  var appInfo: App!
  
  override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
    return 1
  }
  
  override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return apps.count
  }
  
  override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath)
    -> UITableViewCell {
      let cell = self.tableView.dequeueReusableCellWithIdentifier("CellView", forIndexPath: indexPath) as! CellView
      
      let appInfo = apps[indexPath.row] as App
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
      let viewController = segue.destinationViewController as! AppInfoViewController
      viewController.appInfo = apps[path.indexAtPosition(1)]
    }
    
  }
}
