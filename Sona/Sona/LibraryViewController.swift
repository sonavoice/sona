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
