import Foundation
import CoreData

class AppManager: NSObject {
  var context:NSManagedObjectContext
  override init(){
    let appDel:AppDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
    self.context = appDel.managedObjectContext
    super.init()
  }
  
  func savePassport(appName: String, passport: AnyObject){
    let request = NSFetchRequest(entityName: "AppToken")
    request.returnsObjectsAsFaults = false;
    request.predicate = NSPredicate(format: "name == %@", appName)
    
    do {
      let results:NSArray = try context.executeFetchRequest(request)
      if results.count == 0 {
        let entity = NSEntityDescription.entityForName("AppToken", inManagedObjectContext: self.context)
        let token = AppToken(entity: entity!, insertIntoManagedObjectContext: self.context)
        token.name = appName
        token.passport = passport
        try self.context.save()
      } else {
        results[0].setValue(passport, forKey: "passport")
        try self.context.save()
      }
    } catch {
      print("Error: Failed to save token")
    }
  }
  
  func getPassport(appName: String) -> AnyObject? {
    let request = NSFetchRequest(entityName: "AppToken")
    request.returnsObjectsAsFaults = false;
    request.predicate = NSPredicate(format: "name == %@", appName)
    
    do {
      let results:NSArray = try context.executeFetchRequest(request)
      if results.count == 0 {
        return nil
      } else {
        return results[0].valueForKey("passport")!
      }
    } catch {
      print("Error: Failed to save token")
      return nil
    }
  }
  
  func deleteExt(extensionName: String) -> String? {
    let request = NSFetchRequest(entityName: "AppToken")
    request.returnsObjectsAsFaults = false;
    request.predicate = NSPredicate(format: "name == %@", extensionName)
    
    do {
      let results:NSArray = try context.executeFetchRequest(request)
      if results.count == 0 {
        return nil
      } else {
        var extName = results[0].valueForKey("name")!
        self.context.deleteObject(results[0] as! NSManagedObject)
        return extName as! String
      }
    } catch {
      print("Error: Failed to save token")
      return nil
    }
  }
  
  func scan(transcriptArray: [String]) -> String? {
    let request = NSFetchRequest(entityName: "AppToken")
    request.returnsObjectsAsFaults = false
    request.predicate = nil
    // Load all local app to an array
    do {
      let results = try context.executeFetchRequest(request)
      if results.count != 0 {
        var counter = 0
        for element in transcriptArray {
          for apps in results {
            if element == (apps.valueForKey("name") as! String) {
              return apps.valueForKey("name") as! String
            }
          }
          counter++
          if(counter > 3) {
            break
          }
        }
      } else {
        return nil
      }
    } catch {
      print("Error: Failed to search app. check local storage")
    }
    // check first 3 elements
    return nil
  }
}
