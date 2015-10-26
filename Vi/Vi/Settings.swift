//
//  Settings.swift
//  Vi
//
//  Created by Qwerty on 10/24/15.
//  Copyright © 2015 Vi. All rights reserved.
//

import UIKit
import CoreData

class Settings: NSManagedObject {
  
  @NSManaged var name:String
  @NSManaged var status:NSNumber
  
}
