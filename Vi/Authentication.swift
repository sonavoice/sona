import Foundation
import Lock

class Authentication: NSObject {
  static let sharedInstance = Authentication()
  let lock: A0Lock
  
  private override init() {
    lock = A0Lock()
  }
  
  func authenticatePlatform(view: UIViewController, platform: String) {
    let lock = Authentication.sharedInstance.lock
    let controller = lock.newLockViewController()
    controller.closable = true
    controller.onAuthenticationBlock = { (profile, token) in
      NSLog("User token: %@", token!)
      NSLog("User profile: %@", profile!)
      view.dismissViewControllerAnimated(true, completion: nil)
    }
    view.presentViewController(controller, animated: true, completion: nil)
  }
  
}
