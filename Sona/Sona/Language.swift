import UIKit
import CoreData

class Language: NSManagedObject {
  
  @NSManaged var name:String
  @NSManaged var ref:String
  
}