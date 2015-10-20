//
//  SettingsViewController.swift
//  Vi
//
//  Created by Qwerty on 10/20/15.
//  Copyright © 2015 Vi. All rights reserved.
//

// Settings customization.
// This file overrides UITableViewController functions to allow customization of settings

import UIKit

class SettingsViewController: UITableViewController {
  
  override func viewDidLoad() {
    super.viewDidLoad()
    self.tableView.allowsSelection = false
    self.tableView.backgroundColor = UIColor(red: 243.0/255, green: 243.0/255, blue: 243.0/255, alpha: 1)
  }
  
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }
  
  override func tableView(tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
    let headerView = view as! UITableViewHeaderFooterView
    headerView.textLabel!.textColor = UIColor(red: 151.0/255, green: 193.0/255, blue: 100.0/255, alpha: 1)
    
    if let font = UIFont(name: "Montserrat", size: 18.0){
      headerView.textLabel?.font = font
    }
  }
}
