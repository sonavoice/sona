import Foundation
import Lock

class Authentication: NSObject {
  static let sharedInstance = Authentication()
  let lock: A0Lock
  
  private override init() {
    lock = A0Lock()
  }
  
  func authenticatePlatform(view: UIViewController, platform: String) {
    let newLock = Authentication.sharedInstance.lock
//    let controller = newLock.newLockViewController()
//    controller.closable = true
    newLock.identityProviderAuthenticator().authenticateWithConnectionName(platform, parameters: nil, success: self.successCallback(), failure: self.errorCallback())
    
//    controller.onAuthenticationBlock = { (profile, token) in
//      NSLog("User token: %@", token!)
//      NSLog("User profile: %@", profile!)
//      view.dismissViewControllerAnimated(true, completion: nil)
//    }
//    view.presentViewController(controller, animated: true, completion: nil)
  }
  
  private func errorCallback() -> NSError -> () {
    return { error in
      let alert = UIAlertController(title: "Login failed", message: "Please check you application logs for more info", preferredStyle: .Alert)
      alert.addAction(UIAlertAction(title: "OK", style: .Default, handler: nil))
      self.presentViewController(alert, animated: true, completion: nil)
      print("Failed with error \(error)")
    }
  }
  
  private func successCallback() -> (A0UserProfile, A0Token) -> () {
    return { (profile, token) -> Void in
      let alert = UIAlertController(title: "Logged In!", message: "User with name \(profile.name) logged in!", preferredStyle: .Alert)
      alert.addAction(UIAlertAction(title: "OK", style: .Default, handler: nil))
      self.presentViewController(alert, animated: true, completion: nil)
      print("Logged in user \(profile.name)")
      print("Tokens: \(token)")
    }
  }
  
}
