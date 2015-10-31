//
//  LanguageOptionViewController.swift
//  Vi
//
//  Created by Qwerty on 10/28/15.
//  Copyright © 2015 Vi. All rights reserved.
//

import UIKit
import CoreData

class LanguageOptionViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
  @IBOutlet weak var langTable: UITableView!
  let choices = languages
  var choice = []
  
  override func viewDidLoad() {
    self.langTable.dataSource = self
    self.langTable.delegate = self
    let langMan = LanguageManager()
    self.choice = langMan.getCurrentLang()
  }
  
  func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return self.choices.count
  }
  
  func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath)
    -> UITableViewCell {
      
      let cell = UITableViewCell()
      let label = UILabel(frame: CGRect(x:0, y:0, width:100, height:50))
      label.text = self.choices[indexPath.row][0]
      
      cell.addSubview(label)
      return cell
  }
  
  func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
    self.choice = languages[indexPath.row]
  }
  
  @IBAction func cancelLang(sender: AnyObject) {
    self.dismissViewControllerAnimated(true, completion: nil)
  }
  
  @IBAction func saveLang(sender: AnyObject) {
    let langMan = LanguageManager()
    langMan.setCurrentLang(self.choice[0] as! String, internalName: self.choice[1] as! String)
    self.dismissViewControllerAnimated(true, completion: nil)
  }
  
}