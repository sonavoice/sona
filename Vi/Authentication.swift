import UIKit
import Lock

class Authentication: NSObject {
  static let sharedInstance = Authentication()
  let lock: A0Lock
  
  private override init() {
    lock = A0Lock()
  }
}
