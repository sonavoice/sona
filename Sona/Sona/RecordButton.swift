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
  
  let primary: UIColor = UIColor(red: 249.0/255, green: 53.0/255, blue: 78.0/255, alpha: 1)
  let primaryLight: UIColor = UIColor(red: 255.0/255, green: 232.0/255, blue: 235.0/255, alpha: 1)
  
  override func drawRect(rect: CGRect) {
    let path = UIBezierPath(ovalInRect: rect)
    primary.setFill()
    path.fill()
    
    let center = CGPoint(x:bounds.width/2, y: bounds.height/2)
    let radius: CGFloat = max(bounds.width, bounds.height)/2
    
    var arcWidth: CGFloat = radius*0.5
    let startAngle: CGFloat = 0
    let endAngle: CGFloat = 2 * PI
    
    let innerRing = UIBezierPath(arcCenter: center, radius: radius - (radius/2.5)+0.5, startAngle: startAngle, endAngle: endAngle, clockwise: true)
    
    innerRing.lineWidth = arcWidth
    primaryLight.setStroke()
    innerRing.stroke()
    
    
    arcWidth = radius * 0.14
    
    let whiteRing = UIBezierPath(arcCenter: center, radius: radius - (arcWidth*1.0)+0.5, startAngle: startAngle, endAngle: endAngle, clockwise: true)
    
    whiteRing.lineWidth = arcWidth
    UIColor.whiteColor().setStroke()
    whiteRing.stroke()
    
    arcWidth = radius*0.07
    
    let outerRing = UIBezierPath(arcCenter: center, radius: radius - (arcWidth/2), startAngle: startAngle, endAngle: endAngle, clockwise: true)
    
    outerRing.lineWidth = arcWidth
    primaryLight.setStroke()
    outerRing.stroke()
  }
  
}
