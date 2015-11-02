import Foundation
import CoreData

class DataInitializer: NSObject {
  init(context: NSManagedObjectContext){
    super.init()
    let appDel:AppDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
    let context:NSManagedObjectContext = appDel.managedObjectContext

    self.initiateLanguage(context)
    self.initiateSetting(context)

  }

  func initiateLanguage(context: NSManagedObjectContext){
    let entity = NSEntityDescription.entityForName("Language", inManagedObjectContext: context)
    
    let defaultLang = Language(entity: entity!, insertIntoManagedObjectContext: context)
    defaultLang.name = "English"
    defaultLang.ref = "eng-USA"
    
    do {
      try context.save()
    } catch {
      NSLog("Failed to save default language")
    }
  }
  
  func initiateSetting(context: NSManagedObjectContext){
    let entity = NSEntityDescription.entityForName("Settings", inManagedObjectContext: context)
    
    let setting1 = Settings(entity: entity!, insertIntoManagedObjectContext: context)
    setting1.name = "alwaysListen"
    setting1.status = true
    
    let setting2 = Settings(entity: entity!, insertIntoManagedObjectContext: context)
    setting2.name = "UIsound"
    setting2.status = true
    
    let setting3 = Settings(entity: entity!, insertIntoManagedObjectContext: context)
    setting3.name = "autoUpdate"
    setting3.status = true
    
    let setting4 = Settings(entity: entity!, insertIntoManagedObjectContext: context)
    setting4.name = "notifyUpdate"
    setting4.status = true
    
    let setting5 = Settings(entity: entity!, insertIntoManagedObjectContext: context)
    setting5.name = "responseVoiceOnOff"
    setting5.status = true
    
    do {
      try context.save()
    } catch {
      NSLog("Failed to save default settings")
    }
  }
  
  func matchSetting(ID: NSInteger) -> NSString {
    switch ID {
    case 1:
      return "alwaysListen"
    case 2:
      return "UIsound"
    case 3:
      return "autoUpdate"
    case 4:
      return "notifyUpdate"
    case 5:
      return "responseVoiceOnOff"
    default:
      return "error: no such settings"
    }
  }
}
