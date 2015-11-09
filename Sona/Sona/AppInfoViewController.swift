import UIKit
import Lock

class AppInfoViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

  var appInfo: App!
  let appManager = AppManager()
  var signedIn = false
  
  @IBOutlet weak var icon: UIImageView!
  @IBOutlet weak var appTitle: UILabel!
  @IBOutlet weak var appDescription: UILabel!
  @IBOutlet weak var CommandView: UITableView!
  
  func signInOut() {
    if signedIn {
      /* Sign out */
      /* Remove token */
      appManager.deleteExt(appTitle.text!)
      
      self.navigationItem.rightBarButtonItem?.title = "Sign In"
      self.signedIn = false
    } else {
      /* Sign in */
      /* Auth sequence */
      let signinController: SigninViewController = SigninViewController()
      signinController.appname = appInfo.name!
      self.presentViewController(signinController, animated: true, completion: nil)
      
      self.navigationItem.rightBarButtonItem?.title = "Log out"
      self.signedIn = true
    }
  }
  
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
    
    self.navigationController?.navigationBar.setBackgroundImage(UIImage(), forBarMetrics: UIBarMetrics.Default)
    self.navigationController?.navigationBar.shadowImage = UIImage()
    self.navigationController?.navigationBar.translucent = true
    self.navigationController?.view.backgroundColor = UIColor.clearColor()
    
    self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Sign In", style: .Done, target: self, action: "signInOut")
    
    if (appManager.scan([appTitle.text!]) != nil) {
      self.navigationItem.rightBarButtonItem?.title = "Log out"
      self.signedIn = true
    } else {
      self.navigationItem.rightBarButtonItem?.title = "Sign In"
      self.signedIn = false
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
    
    cell.textLabel!.font = UIFont(name: "Lato-Regular", size: 13)
    cell.textLabel?.textColor = UIColor(red: 33/255.0, green: 33/255.0, blue: 33/255.0, alpha: 1)
    cell.textLabel?.text = self.appInfo.commands[indexPath.row]
    
    cell.textLabel?.numberOfLines = 0
    cell.layoutMargins = UIEdgeInsetsZero
    cell.preservesSuperviewLayoutMargins = false
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
