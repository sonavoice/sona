//
//  LanguageManager.swift
//  Vi
//
//  Created by Qwerty on 10/30/15.
//  Copyright © 2015 Vi. All rights reserved.
//

import Foundation
import CoreData

class LanguageManager: NSObject {
  var context:NSManagedObjectContext
  override init(){
    let appDel:AppDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
    self.context = appDel.managedObjectContext
    super.init()
  }
  
  func getCurrentLang() -> [String] {
    let request = NSFetchRequest(entityName: "Language")
    request.returnsObjectsAsFaults = false;
    request.predicate = nil
    
    do {
      let results:NSArray = try context.executeFetchRequest(request)
      return [results[0].valueForKey("name") as! String, results[0].valueForKey("ref") as! String]
    } catch {
      return ["Error"]
    }
  }
  
  func setCurrentLang(langName: String, internalName: String) {
    let request = NSFetchRequest(entityName: "Language")
    request.returnsObjectsAsFaults = false;
    request.predicate = nil
    
    do {
      let results:NSArray = try context.executeFetchRequest(request)
      results[0].setValue(langName, forKey: "name")
      results[0].setValue(internalName, forKey: "ref")
      try context.save()
    } catch {
      
    }
  }
}