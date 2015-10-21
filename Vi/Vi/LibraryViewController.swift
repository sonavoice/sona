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
  
  override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
    return 1
  }
  
  override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return apps.count
  }
  
  override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath)
    -> UITableViewCell {
      let cell = tableView.dequeueReusableCellWithIdentifier("AppInfo", forIndexPath: indexPath)
      
      let appInfo = apps[indexPath.row] as App
      cell.textLabel?.text = appInfo.name
      cell.detailTextLabel?.text = appInfo.description
      return cell
  }
  
//  override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
//    
//    
//    let selectedApp = apps[indexPath.row]
//    
//    let destinationVC = AppInfoViewController(data: selectedApp)
//    
//    destinationVC.performSegueWithIdentifier("appSegue", sender: self)
//  }
}
