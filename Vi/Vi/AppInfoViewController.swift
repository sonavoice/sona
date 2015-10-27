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
  
  @IBOutlet weak var icon: UIImageView!
  @IBOutlet weak var appTitle: UILabel!
  @IBOutlet weak var appDescription: UILabel!
  @IBOutlet weak var CommandView: UITableView!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    appTitle.text = self.appInfo.name
    appDescription.text = self.appInfo.description
    
    let url = NSURL(string: self.appInfo.iconURL!)
    let data = NSData(contentsOfURL: url!) //make sure your image in this url does exist, otherwise unwrap in a if let check
    
    if data == nil {
      icon.image = UIImage(named: "image1")
    } else {
      icon.image = UIImage(data: data!)
    }
    
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
    
//    cell.textLabel!.adjustsFontSizeToFitWidth = true
//    cell.textLabel!.minimumScaleFactor = 0.1
    cell.textLabel!.font = UIFont(name: "Lato-Regular", size: 11)
    cell.textLabel?.textColor = UIColor(red: 33/255.0, green: 33/255.0, blue: 33/255.0, alpha: 1)
    cell.textLabel?.text = self.appInfo.commands[indexPath.row]
    cell.textLabel?.numberOfLines = 0
    cell.textLabel?.sizeToFit()
    
    return cell
  }
  
  override func viewWillAppear(animated: Bool) {
    super.viewWillAppear(true)
    
    self.CommandView.estimatedRowHeight = 150 // for example. Set your average height
    self.CommandView.rowHeight = UITableViewAutomaticDimension
    self.CommandView.reloadData()
  }
  
}
