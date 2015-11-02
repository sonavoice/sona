//
//  App.swift
//  Vi
//
//  Created by Eugene Lee (colemakdvorak) on 10/21/15.
//  Copyright © 2015 Vi. All rights reserved.
//

import UIKit

struct App {
  var name: String?
  var description: String?
  var commands: [String]
  var iconURL: String?
  
  init(name: String?, description: String?, commands: [String]?, iconURL: String?){
    self.name = name
    self.description = description
    self.commands = commands!
    self.iconURL = iconURL
  }
}
