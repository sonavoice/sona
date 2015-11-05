import UIKit
import CoreData

class AppToken: NSManagedObject {
  
  @NSManaged var name:String
  @NSManaged var passport: AnyObject
  
}