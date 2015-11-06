import UIKit
import CoreData

class LanguageOptionViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
  @IBOutlet weak var langTable: UITableView!
  let choices = languages
  var choice = []
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    self.navigationController?.navigationBar.setBackgroundImage(UIImage(), forBarMetrics: UIBarMetrics.Default)
    self.navigationController?.navigationBar.shadowImage = UIImage()
    self.navigationController?.navigationBar.translucent = true
    self.navigationController?.view.backgroundColor = UIColor.clearColor()
    
    self.langTable.dataSource = self
    self.langTable.delegate = self
    let langMan = LanguageManager()
    self.choice = langMan.getCurrentLang()
    
    self.navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Cancel", style: .Done, target: self, action: "cancelLang")
    self.navigationItem.leftBarButtonItem?.tintColor = UIColor(red: 0.984, green: 0.153, blue: 0.247, alpha: 1.000)
  }
  
  func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return self.choices.count
  }
  
  func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath)
    -> UITableViewCell {
      
      let cell = UITableViewCell()
      let label = UILabel(frame: CGRect(x:0, y:0, width:100, height:50))
      label.text = self.choices[indexPath.row][0]
      
      cell.layoutMargins = UIEdgeInsetsZero
      cell.preservesSuperviewLayoutMargins = false
      
      cell.addSubview(label)
      return cell
  }
  
  func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
    self.choice = languages[indexPath.row]
    let langMan = LanguageManager()
    langMan.setCurrentLang(self.choice[0] as! String, internalName: self.choice[1] as! String)
    self.dismissViewControllerAnimated(true, completion: nil)
  }
  
  func cancelLang() {
    self.dismissViewControllerAnimated(true, completion: nil)
  }
}