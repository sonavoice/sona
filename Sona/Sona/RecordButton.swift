//
//  RecordButton.swift
//  Sona
//
//  Created by Christopher Yung on 11/2/15.
//  Copyright © 2015 Sona. All rights reserved.
//

import UIKit
import QuartzCore

let PI:CGFloat = CGFloat(M_PI)

@IBDesignable
class RecordButton: UIButton {
  
  var animating = false
  
  override init(frame: CGRect) {
    super.init(frame: frame)
  }

  required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
  }
  
  override func drawRect(rect: CGRect) {
    
    //// Color Declarations
    let primary = UIColor(red: 0.984, green: 0.153, blue: 0.247, alpha: 1.000)
    let primaryLight = UIColor(red: 1.000, green: 0.725, blue: 0.753, alpha: 1.000)
    
    //// outerRing Drawing
    let outerRingPath = UIBezierPath(ovalInRect: CGRectMake(0, 0, 150, 150))
    primary.setFill()
    outerRingPath.fill()
    
    //// innerRing Drawing
    let innerRingPath = UIBezierPath(ovalInRect: CGRectMake(4, 4, 142, 142))
    primaryLight.setFill()
    innerRingPath.fill()
    
    //// innerCircle Drawing
    let innerCirclePath = UIBezierPath(ovalInRect: CGRectMake(15, 15, 120, 120))
    UIColor.whiteColor().setFill()
    innerCirclePath.fill()
    self.addTarget(self, action: "pressAnimation", forControlEvents: .TouchUpInside)
  }
  
  func pressAnimation() {
    self.animating = !self.animating
    self.pulse()
  }
  
  func pulse() {
    /* Options for Keyframes and UI */
    UIView.animateWithDuration(0.5 , delay: 0.0, options: [.AllowUserInteraction, .AllowUserInteraction],
      animations: {
        self.transform = CGAffineTransformMakeScale(0.85, 0.85)
      },
      completion: { finish in
        UIView.animateWithDuration(0.5 , delay: 0.0, options: .TransitionNone,
          animations: {
            self.transform = CGAffineTransformIdentity
          },
          completion: { finish in
            if self.animating {
              self.pulse()
            }
        })
    })
  }
  
}
