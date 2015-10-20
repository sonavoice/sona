//
//  HomeGestureViewController.swift
//  Vi
//
//  Created by Eugene Lee (colemakdvorak) on 10/20/15.
//  Copyright © 2015 Vi. All rights reserved.
//
import UIKit

class HomeGestureViewController: UIViewController {
  
  @IBOutlet weak var swipeLabel: UILabel?
  var listening:Bool = false
  
  override func viewDidLoad() {
    super.viewDidLoad()
    let upSwipe = UISwipeGestureRecognizer(target: self, action: Selector("handleSwipes:"))
    upSwipe.direction = .Up
    view.addGestureRecognizer(upSwipe)
    
//    let leftSwipe = UISwipeGestureRecognizer(target: self, action: Selector("handleSwipes:"))
//    leftSwipe.direction = .Left
//    view.addGestureRecognizer(leftSwipe)
//    
//    let rightSwipe = UISwipeGestureRecognizer(target: self, action: Selector("handleSwipes:"))
//    rightSwipe.direction = .Right
//    view.addGestureRecognizer(rightSwipe)
//    
//    let downSwipe = UISwipeGestureRecognizer(target: self, action: Selector("handleSwipes:"))
//    downSwipe.direction = .Down
//    view.addGestureRecognizer(downSwipe)
  }
  
  func handleSwipes(sender:UISwipeGestureRecognizer) {
    if (sender.direction == .Up) {
      print("Swipe Up")
      listening = !listening
      print("Listening: \(listening)")
    }
    
//    if (sender.direction == .Left) {
//      print("Swipe Left")
//    }
//    
//    if (sender.direction == .Right) {
//      print("Swipe Right")
//    }
//  
//    if (sender.direction == .Down) {
//      print("Swipe Down")
//    }
  }
  
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }

}