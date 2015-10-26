//
//  DummyData.swift
//  Vi
//
//  Created by Eugene Lee (colemakdvorak) on 10/21/15.
//  Copyright © 2015 Vi. All rights reserved.
//

import Foundation

let dummyData = [
  App(name: "Github", description: "the home of open source that lived 2200 miles away from the gym and Costco and I will be informed that", commands: ["Get most recent commit: Reads the most recent commit you have made", "Delete $name: deletes your repository with the name $name"], iconURL: "https://cdn0.iconfinder.com/data/icons/octicons/1024/mark-github-256.png"),
  App(name: "Twitter", description: "Voice command for Twitter, your favorite SNS", commands: ["Tweet $text: Tweet through your account"], iconURL:"https://g.twimg.com/Twitter_logo_blue.png"),
  App(name: "Slack", description: "Talk to your project team through Vi on Slack", commands: ["Post $text on $room: Posts a text you want to a specified room"], iconURL: "https://slack.global.ssl.fastly.net/ba3c/img/icons/app-256.png")
]