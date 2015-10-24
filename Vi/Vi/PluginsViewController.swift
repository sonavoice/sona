//
//  PluginsViewController.swift
//  Vi
//
//  Created by Keith Armstrong on 10/22/15.
//  Copyright © 2015 Vi. All rights reserved.
//

import UIKit

class PluginsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet var tableViewObject: UITableView!
    var foodNames: [String] = ["Food1","Food2","Food3","Food4","Food5","Food6","Food7","Food8"]
    
    var foodImages: [String] = ["image1", "image2", "image3","image4","image5","image6","image7","image8"]
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
      return foodNames.count
    }

    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
      let cell:UITableViewCell=UITableViewCell(style: UITableViewCellStyle.Subtitle, reuseIdentifier: "mycell")
      cell.textLabel!.text = foodNames[indexPath.row]
      let image:UIImage = UIImage(named: foodImages[indexPath.row])!
      cell.imageView!.image = image
      return cell
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
