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
    let primary = UIColor(red: 0.969, green: 0.149, blue: 0.243, alpha: 1.000)
    let light = UIColor(red: 1.000, green: 0.910, blue: 0.918, alpha: 1.000)
    let white = UIColor(red: 1.000, green: 1.000, blue: 1.000, alpha: 1.000)
    
    //// outerRing Drawing
    let outerRingPath = UIBezierPath(ovalInRect: CGRectMake(0, 0, 175, 175))
    light.setFill()
    outerRingPath.fill()
    
    
    //// whiteRing Drawing
    let whiteRingPath = UIBezierPath(ovalInRect: CGRectMake(4, 4, 167, 167))
    white.setFill()
    whiteRingPath.fill()
    
    
    //// InnerRing Drawing
    let innerRingPath = UIBezierPath(ovalInRect: CGRectMake(18, 18, 139, 139))
    light.setFill()
    innerRingPath.fill()
    
    
    //// innerCircle Drawing
    let innerCirclePath = UIBezierPath(ovalInRect: CGRectMake(57, 57, 61, 61))
    primary.setFill()
    innerCirclePath.fill()
  }
  
}
