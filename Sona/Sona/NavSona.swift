//
//  NavSona.swift
//  Sona
//
//  Created by Christopher Yung on 11/4/15.
//  Copyright © 2015 Sona. All rights reserved.
//

import UIKit

class NavSona: UIView {

  override func drawRect(rect: CGRect) {
    //// General Declarations
    let context = UIGraphicsGetCurrentContext()
    
    //// Color Declarations
    let darkSecondary = UIColor(red: 0.133, green: 0.176, blue: 0.239, alpha: 1.000)
    let darkTertiary = UIColor(red: 0.663, green: 0.663, blue: 0.663, alpha: 1.000)
    
    //// Oval Drawing
    let ovalPath = UIBezierPath(ovalInRect: CGRectMake(8, 1, 50, 50))
    darkSecondary.setFill()
    ovalPath.fill()
    
    
    //// SPEECH_2_1_
    //// SPEECH_2
    //// Group 4
    //// Bezier Drawing
    let bezierPath = UIBezierPath()
    bezierPath.moveToPoint(CGPointMake(43.88, 16))
    bezierPath.addLineToPoint(CGPointMake(22.12, 16))
    bezierPath.addCurveToPoint(CGPointMake(21, 17.19), controlPoint1: CGPointMake(21.5, 16), controlPoint2: CGPointMake(21, 16.53))
    bezierPath.addLineToPoint(CGPointMake(21, 34.24))
    bezierPath.addCurveToPoint(CGPointMake(22.12, 35.43), controlPoint1: CGPointMake(21, 34.9), controlPoint2: CGPointMake(21.5, 35.43))
    bezierPath.addLineToPoint(CGPointMake(23.62, 35.43))
    bezierPath.addLineToPoint(CGPointMake(23.62, 37.81))
    bezierPath.addCurveToPoint(CGPointMake(23.65, 38.05), controlPoint1: CGPointMake(23.62, 37.89), controlPoint2: CGPointMake(23.63, 37.97))
    bezierPath.addCurveToPoint(CGPointMake(23.69, 38.21), controlPoint1: CGPointMake(23.66, 38.1), controlPoint2: CGPointMake(23.68, 38.15))
    bezierPath.addCurveToPoint(CGPointMake(23.71, 38.27), controlPoint1: CGPointMake(23.7, 38.23), controlPoint2: CGPointMake(23.7, 38.25))
    bezierPath.addCurveToPoint(CGPointMake(23.78, 38.4), controlPoint1: CGPointMake(23.73, 38.32), controlPoint2: CGPointMake(23.76, 38.36))
    bezierPath.addCurveToPoint(CGPointMake(23.82, 38.48), controlPoint1: CGPointMake(23.79, 38.43), controlPoint2: CGPointMake(23.8, 38.45))
    bezierPath.addCurveToPoint(CGPointMake(23.94, 38.64), controlPoint1: CGPointMake(23.85, 38.53), controlPoint2: CGPointMake(23.9, 38.59))
    bezierPath.addCurveToPoint(CGPointMake(23.95, 38.65), controlPoint1: CGPointMake(23.95, 38.64), controlPoint2: CGPointMake(23.95, 38.65))
    bezierPath.addCurveToPoint(CGPointMake(24.74, 39), controlPoint1: CGPointMake(24.16, 38.86), controlPoint2: CGPointMake(24.43, 38.99))
    bezierPath.addCurveToPoint(CGPointMake(24.75, 39), controlPoint1: CGPointMake(24.74, 39), controlPoint2: CGPointMake(24.75, 39))
    bezierPath.addCurveToPoint(CGPointMake(25.55, 38.65), controlPoint1: CGPointMake(25.06, 39), controlPoint2: CGPointMake(25.34, 38.87))
    bezierPath.addLineToPoint(CGPointMake(28.59, 35.43))
    bezierPath.addLineToPoint(CGPointMake(43.88, 35.43))
    bezierPath.addCurveToPoint(CGPointMake(45, 34.24), controlPoint1: CGPointMake(44.5, 35.43), controlPoint2: CGPointMake(45, 34.9))
    bezierPath.addLineToPoint(CGPointMake(45, 17.19))
    bezierPath.addCurveToPoint(CGPointMake(43.88, 16), controlPoint1: CGPointMake(45, 16.53), controlPoint2: CGPointMake(44.5, 16))
    bezierPath.closePath()
    bezierPath.miterLimit = 4;
    
    darkTertiary.setFill()
    bezierPath.fill()
    
    
    
    
    
    
    
    
    //// Text Drawing
    let textRect = CGRectMake(0, 50, 66, 21)
    let textTextContent = NSString(string: "SONA")
    let textStyle = NSParagraphStyle.defaultParagraphStyle().mutableCopy() as! NSMutableParagraphStyle
    textStyle.alignment = .Center
    
    let textFontAttributes = [NSFontAttributeName: UIFont(name: "Roboto-Regular", size: 13)!, NSForegroundColorAttributeName: darkTertiary, NSParagraphStyleAttributeName: textStyle]
    
    let textTextHeight: CGFloat = textTextContent.boundingRectWithSize(CGSizeMake(textRect.width, CGFloat.infinity), options: NSStringDrawingOptions.UsesLineFragmentOrigin, attributes: textFontAttributes, context: nil).size.height
    CGContextSaveGState(context)
    CGContextClipToRect(context, textRect);
    textTextContent.drawInRect(CGRectMake(textRect.minX, textRect.minY + (textRect.height - textTextHeight) / 2, textRect.width, textTextHeight), withAttributes: textFontAttributes)
    CGContextRestoreGState(context)

  }
}
