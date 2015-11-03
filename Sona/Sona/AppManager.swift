import Foundation
import CoreData

class AppManager: NSObject {
  var context:NSManagedObjectContext
  override init(){
    let appDel:AppDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
    self.context = appDel.managedObjectContext
    super.init()
  }
  
  func saveToken(appName: String, tokenToSave: String){
    let request = NSFetchRequest(entityName: "AppToken")
    request.returnsObjectsAsFaults = false;
    request.predicate = NSPredicate(format: "name == %@", appName)
    
    do {
      let results:NSArray = try context.executeFetchRequest(request)
      if results.count == 0 {
        let entity = NSEntityDescription.entityForName("AppToken", inManagedObjectContext: self.context)
        let token = AppToken(entity: entity!, insertIntoManagedObjectContext: self.context)
        token.name = appName
        token.token = tokenToSave
        try self.context.save()
      } else {
        results[0].setValue(tokenToSave, forKey: "token")
        try self.context.save()
      }
    } catch {
      print("Error: Failed to save token")
    }
  }
  
  func getToken(appName: String) -> String? {
    let request = NSFetchRequest(entityName: "AppToken")
    request.returnsObjectsAsFaults = false;
    request.predicate = NSPredicate(format: "name == %@", appName)
    
    do {
      let results:NSArray = try context.executeFetchRequest(request)
      if results.count == 0 {
        return nil
      } else {
        return results[0].valueForKey("token") as! String?
      }
    } catch {
      print("Error: Failed to save token")
      return nil
    }
  }
  
  func scan(transcriptArray: [String]) -> String? {
    let request = NSFetchRequest(entityName: "AppToken")
    let results:NSArray = []
    request.returnsObjectsAsFaults = false;
    // Load all local app to an array
    do {
      let results = try context.executeFetchRequest(request)
      if results.count == 0 {
        return nil
      } else {
        
      }
    } catch {
      print("Error: Failed to search app. check local storage")
    }
    // check first 3 elements
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
    return nil
  }
}
