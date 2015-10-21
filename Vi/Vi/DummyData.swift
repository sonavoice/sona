//
//  DummyData.swift
//  Vi
//
//  Created by Eugene Lee (colemakdvorak) on 10/21/15.
//  Copyright © 2015 Vi. All rights reserved.
//

import Foundation

let dummyData = [
  App(name: "Github", description: "Voice command for github, the home of open source", commands: ["Get most recent commit: Reads the most recent commit you have made", "Delete $name: deletes your repository with the name $name"]),
  App(name: "Twitter", description: "Voice command for Twitter, your favorite SNS", commands: ["Tweet $text: Tweet through your account"]),
  App(name: "Slack", description: "Talk to your project team through Vi on Slack", commands: ["Post $text on $room: Posts a text you want to a specified room"])
]