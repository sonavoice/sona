//
//  AppToken.swift
//  Vi
//
//  Created by Qwerty on 10/29/15.
//  Copyright © 2015 Vi. All rights reserved.
//

import UIKit
import CoreData

class AppToken: NSManagedObject {
  
  @NSManaged var name:String
  @NSManaged var token:String
  
}