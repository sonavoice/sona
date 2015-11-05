//
//  NavLibrary.swift
//  Sona
//
//  Created by Christopher Yung on 11/4/15.
//  Copyright © 2015 Sona. All rights reserved.
//

import UIKit

class NavLibrary: UIView {

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
      
      
      //// Text Drawing
      let textRect = CGRectMake(0, 50, 66, 21)
      let textTextContent = NSString(string: "LIBRARY")
      let textStyle = NSParagraphStyle.defaultParagraphStyle().mutableCopy() as! NSMutableParagraphStyle
      textStyle.alignment = .Center
      
      let textFontAttributes = [NSFontAttributeName: UIFont(name: "Roboto-Regular", size: 13)!, NSForegroundColorAttributeName: darkTertiary, NSParagraphStyleAttributeName: textStyle]
      
      let textTextHeight: CGFloat = textTextContent.boundingRectWithSize(CGSizeMake(textRect.width, CGFloat.infinity), options: NSStringDrawingOptions.UsesLineFragmentOrigin, attributes: textFontAttributes, context: nil).size.height
      CGContextSaveGState(context)
      CGContextClipToRect(context, textRect);
      textTextContent.drawInRect(CGRectMake(textRect.minX, textRect.minY + (textRect.height - textTextHeight) / 2, textRect.width, textTextHeight), withAttributes: textFontAttributes)
      CGContextRestoreGState(context)
      
      
      //// Bezier Drawing
      let bezierPath = UIBezierPath()
      bezierPath.moveToPoint(CGPointMake(22.94, 31.32))
      bezierPath.addLineToPoint(CGPointMake(20.31, 31.32))
      bezierPath.addCurveToPoint(CGPointMake(19, 32.66), controlPoint1: CGPointMake(19.59, 31.32), controlPoint2: CGPointMake(19, 31.92))
      bezierPath.addCurveToPoint(CGPointMake(20.31, 34), controlPoint1: CGPointMake(19, 33.4), controlPoint2: CGPointMake(19.59, 34))
      bezierPath.addLineToPoint(CGPointMake(22.94, 34))
      bezierPath.addLineToPoint(CGPointMake(22.94, 34))
      bezierPath.addCurveToPoint(CGPointMake(24.25, 32.66), controlPoint1: CGPointMake(23.66, 34), controlPoint2: CGPointMake(24.25, 33.4))
      bezierPath.addCurveToPoint(CGPointMake(22.94, 31.32), controlPoint1: CGPointMake(24.25, 31.92), controlPoint2: CGPointMake(23.66, 31.32))
      bezierPath.closePath()
      bezierPath.moveToPoint(CGPointMake(45.69, 24.16))
      bezierPath.addLineToPoint(CGPointMake(28.19, 24.16))
      bezierPath.addCurveToPoint(CGPointMake(26.88, 25.5), controlPoint1: CGPointMake(27.46, 24.16), controlPoint2: CGPointMake(26.88, 24.76))
      bezierPath.addCurveToPoint(CGPointMake(28.19, 26.84), controlPoint1: CGPointMake(26.88, 26.24), controlPoint2: CGPointMake(27.46, 26.84))
      bezierPath.addLineToPoint(CGPointMake(28.19, 26.84))
      bezierPath.addLineToPoint(CGPointMake(45.69, 26.84))
      bezierPath.addCurveToPoint(CGPointMake(47, 25.5), controlPoint1: CGPointMake(46.41, 26.84), controlPoint2: CGPointMake(47, 26.24))
      bezierPath.addCurveToPoint(CGPointMake(45.69, 24.16), controlPoint1: CGPointMake(47, 24.76), controlPoint2: CGPointMake(46.41, 24.16))
      bezierPath.closePath()
      bezierPath.moveToPoint(CGPointMake(22.94, 24.16))
      bezierPath.addLineToPoint(CGPointMake(20.31, 24.16))
      bezierPath.addCurveToPoint(CGPointMake(19, 25.5), controlPoint1: CGPointMake(19.59, 24.16), controlPoint2: CGPointMake(19, 24.76))
      bezierPath.addCurveToPoint(CGPointMake(20.31, 26.84), controlPoint1: CGPointMake(19, 26.24), controlPoint2: CGPointMake(19.59, 26.84))
      bezierPath.addLineToPoint(CGPointMake(22.94, 26.84))
      bezierPath.addLineToPoint(CGPointMake(22.94, 26.84))
      bezierPath.addCurveToPoint(CGPointMake(24.25, 25.5), controlPoint1: CGPointMake(23.66, 26.84), controlPoint2: CGPointMake(24.25, 26.24))
      bezierPath.addCurveToPoint(CGPointMake(22.94, 24.16), controlPoint1: CGPointMake(24.25, 24.76), controlPoint2: CGPointMake(23.66, 24.16))
      bezierPath.closePath()
      bezierPath.moveToPoint(CGPointMake(28.19, 19.68))
      bezierPath.addLineToPoint(CGPointMake(45.69, 19.68))
      bezierPath.addCurveToPoint(CGPointMake(47, 18.34), controlPoint1: CGPointMake(46.41, 19.68), controlPoint2: CGPointMake(47, 19.08))
      bezierPath.addCurveToPoint(CGPointMake(45.69, 17), controlPoint1: CGPointMake(47, 17.6), controlPoint2: CGPointMake(46.41, 17))
      bezierPath.addLineToPoint(CGPointMake(28.19, 17))
      bezierPath.addLineToPoint(CGPointMake(28.19, 17))
      bezierPath.addCurveToPoint(CGPointMake(26.88, 18.34), controlPoint1: CGPointMake(27.46, 17), controlPoint2: CGPointMake(26.88, 17.6))
      bezierPath.addCurveToPoint(CGPointMake(28.19, 19.68), controlPoint1: CGPointMake(26.88, 19.08), controlPoint2: CGPointMake(27.46, 19.68))
      bezierPath.closePath()
      bezierPath.moveToPoint(CGPointMake(22.94, 17))
      bezierPath.addLineToPoint(CGPointMake(22.94, 17))
      bezierPath.addLineToPoint(CGPointMake(20.31, 17))
      bezierPath.addCurveToPoint(CGPointMake(19, 18.34), controlPoint1: CGPointMake(19.59, 17), controlPoint2: CGPointMake(19, 17.6))
      bezierPath.addCurveToPoint(CGPointMake(20.31, 19.68), controlPoint1: CGPointMake(19, 19.08), controlPoint2: CGPointMake(19.59, 19.68))
      bezierPath.addLineToPoint(CGPointMake(22.94, 19.68))
      bezierPath.addCurveToPoint(CGPointMake(24.25, 18.34), controlPoint1: CGPointMake(23.66, 19.68), controlPoint2: CGPointMake(24.25, 19.08))
      bezierPath.addCurveToPoint(CGPointMake(22.94, 17), controlPoint1: CGPointMake(24.25, 17.6), controlPoint2: CGPointMake(23.66, 17))
      bezierPath.closePath()
      bezierPath.moveToPoint(CGPointMake(45.69, 31.32))
      bezierPath.addLineToPoint(CGPointMake(28.19, 31.32))
      bezierPath.addCurveToPoint(CGPointMake(26.88, 32.66), controlPoint1: CGPointMake(27.46, 31.32), controlPoint2: CGPointMake(26.88, 31.92))
      bezierPath.addCurveToPoint(CGPointMake(28.19, 34), controlPoint1: CGPointMake(26.88, 33.4), controlPoint2: CGPointMake(27.46, 34))
      bezierPath.addLineToPoint(CGPointMake(28.19, 34))
      bezierPath.addLineToPoint(CGPointMake(45.69, 34))
      bezierPath.addCurveToPoint(CGPointMake(47, 32.66), controlPoint1: CGPointMake(46.41, 34), controlPoint2: CGPointMake(47, 33.4))
      bezierPath.addCurveToPoint(CGPointMake(45.69, 31.32), controlPoint1: CGPointMake(47, 31.92), controlPoint2: CGPointMake(46.41, 31.32))
      bezierPath.closePath()
      bezierPath.miterLimit = 4;
      
      darkTertiary.setFill()
      bezierPath.fill()
  }

}
