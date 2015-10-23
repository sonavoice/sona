//
//  AppInfoViewController.swift
//  Vi
//
//  Created by Eugene Lee (colemakdvorak) on 10/21/15.
//  Copyright © 2015 Vi. All rights reserved.
//

import UIKit

class AppInfoViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

  var appInfo: App!
  
  @IBOutlet var AppTitle: UILabel!
  @IBOutlet var CommandView: UITableView!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    AppTitle.text = self.appInfo.name
    self.CommandView.registerClass(UITableViewCell.self, forCellReuseIdentifier: "cell")
    self.CommandView.allowsSelection = false
  }
  
  func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return self.appInfo.commands.count
  }
  
  func numberOfSectionsInTableView(tableView: UITableView) -> Int{
    return 1
  }
  
  func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
    let cell:UITableViewCell = self.CommandView.dequeueReusableCellWithIdentifier("cell")!
    
    cell.textLabel!.adjustsFontSizeToFitWidth = true
    cell.textLabel!.minimumScaleFactor = 0.1
    cell.textLabel!.font = UIFont.systemFontOfSize(10.0)
    cell.textLabel?.text = self.appInfo.commands[indexPath.row]
    
    return cell
  }
  
  override func viewWillAppear(animated: Bool) {
    super.viewWillAppear(true)
    
    self.CommandView.estimatedRowHeight = 200 // for example. Set your average height
    self.CommandView.rowHeight = UITableViewAutomaticDimension
    self.CommandView.reloadData()
  }
}
