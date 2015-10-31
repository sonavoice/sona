//
//  AppManager.swift
//  Vi
//
//  Created by Qwerty on 10/29/15.
//  Copyright © 2015 Vi. All rights reserved.
//

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
      print(results)
      return results[0].valueForKey("token") as! String?
    } catch {
      print("Error: Failed to save token")
      return nil;
    }
  }
}
