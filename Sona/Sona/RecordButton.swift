//
//  RecordButton.swift
//  Sona
//
//  Created by Christopher Yung on 11/2/15.
//  Copyright © 2015 Sona. All rights reserved.
//

import UIKit

let PI:CGFloat = CGFloat(M_PI)

@IBDesignable
class RecordButton: UIButton {
  
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
    UIView.animateWithDuration(0.5 , delay: 0.0, options: .TransitionNone,
      animations: {
        self.transform = CGAffineTransformMakeScale(0.85, 0.85)
      },
      completion: { finish in
        UIView.animateWithDuration(0.5 , delay: 0.0, options: .TransitionNone,
          animations: {
            self.transform = CGAffineTransformIdentity
          },
          completion: { finish in
            self.pressAnimation()
        })
    })
  }
  
}
