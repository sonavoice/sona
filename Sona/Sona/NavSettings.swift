//
//  NavSettings.swift
//  Sona
//
//  Created by Christopher Yung on 11/4/15.
//  Copyright © 2015 Sona. All rights reserved.
//

import UIKit

class NavSettings: UIView {

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
      let textTextContent = NSString(string: "SETTINGS")
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
      bezierPath.moveToPoint(CGPointMake(33, 20.75))
      bezierPath.addCurveToPoint(CGPointMake(27.75, 26), controlPoint1: CGPointMake(30.1, 20.75), controlPoint2: CGPointMake(27.75, 23.1))
      bezierPath.addCurveToPoint(CGPointMake(33, 31.25), controlPoint1: CGPointMake(27.75, 28.9), controlPoint2: CGPointMake(30.1, 31.25))
      bezierPath.addCurveToPoint(CGPointMake(38.25, 26), controlPoint1: CGPointMake(35.9, 31.25), controlPoint2: CGPointMake(38.25, 28.9))
      bezierPath.addCurveToPoint(CGPointMake(33, 20.75), controlPoint1: CGPointMake(38.25, 23.1), controlPoint2: CGPointMake(35.9, 20.75))
      bezierPath.closePath()
      bezierPath.moveToPoint(CGPointMake(33, 28.63))
      bezierPath.addCurveToPoint(CGPointMake(30.37, 26), controlPoint1: CGPointMake(31.55, 28.63), controlPoint2: CGPointMake(30.37, 27.45))
      bezierPath.addCurveToPoint(CGPointMake(33, 23.37), controlPoint1: CGPointMake(30.37, 24.55), controlPoint2: CGPointMake(31.55, 23.37))
      bezierPath.addCurveToPoint(CGPointMake(35.63, 26), controlPoint1: CGPointMake(34.45, 23.37), controlPoint2: CGPointMake(35.63, 24.55))
      bezierPath.addCurveToPoint(CGPointMake(33, 28.63), controlPoint1: CGPointMake(35.63, 27.45), controlPoint2: CGPointMake(34.45, 28.63))
      bezierPath.closePath()
      bezierPath.moveToPoint(CGPointMake(43.29, 23.14))
      bezierPath.addCurveToPoint(CGPointMake(42.28, 20.72), controlPoint1: CGPointMake(43.06, 22.28), controlPoint2: CGPointMake(42.71, 21.47))
      bezierPath.addCurveToPoint(CGPointMake(43.24, 16.37), controlPoint1: CGPointMake(42.77, 20.06), controlPoint2: CGPointMake(44.46, 17.59))
      bezierPath.addLineToPoint(CGPointMake(42.62, 15.71))
      bezierPath.addCurveToPoint(CGPointMake(38.27, 16.72), controlPoint1: CGPointMake(41.58, 14.67), controlPoint2: CGPointMake(38.92, 16.3))
      bezierPath.addCurveToPoint(CGPointMake(35.82, 15.71), controlPoint1: CGPointMake(37.51, 16.29), controlPoint2: CGPointMake(36.69, 15.94))
      bezierPath.addCurveToPoint(CGPointMake(33.36, 11.99), controlPoint1: CGPointMake(35.68, 14.88), controlPoint2: CGPointMake(35.08, 11.99))
      bezierPath.addLineToPoint(CGPointMake(32.68, 11.99))
      bezierPath.addCurveToPoint(CGPointMake(30.17, 15.73), controlPoint1: CGPointMake(31.21, 11.99), controlPoint2: CGPointMake(30.36, 14.98))
      bezierPath.addCurveToPoint(CGPointMake(27.76, 16.74), controlPoint1: CGPointMake(29.32, 15.97), controlPoint2: CGPointMake(28.51, 16.31))
      bezierPath.addCurveToPoint(CGPointMake(23.37, 15.78), controlPoint1: CGPointMake(27.16, 16.3), controlPoint2: CGPointMake(24.62, 14.54))
      bezierPath.addLineToPoint(CGPointMake(22.71, 16.34))
      bezierPath.addCurveToPoint(CGPointMake(23.76, 20.78), controlPoint1: CGPointMake(21.63, 17.42), controlPoint2: CGPointMake(23.43, 20.28))
      bezierPath.addCurveToPoint(CGPointMake(22.78, 23.16), controlPoint1: CGPointMake(23.34, 21.52), controlPoint2: CGPointMake(23.01, 22.32))
      bezierPath.addCurveToPoint(CGPointMake(18.99, 25.63), controlPoint1: CGPointMake(22.06, 23.27), controlPoint2: CGPointMake(18.99, 23.86))
      bezierPath.addLineToPoint(CGPointMake(18.99, 26.31))
      bezierPath.addCurveToPoint(CGPointMake(22.8, 28.83), controlPoint1: CGPointMake(18.99, 27.84), controlPoint2: CGPointMake(22.21, 28.69))
      bezierPath.addCurveToPoint(CGPointMake(23.78, 31.2), controlPoint1: CGPointMake(23.03, 29.67), controlPoint2: CGPointMake(23.37, 30.46))
      bezierPath.addCurveToPoint(CGPointMake(22.78, 35.66), controlPoint1: CGPointMake(23.44, 31.74), controlPoint2: CGPointMake(21.71, 34.58))
      bezierPath.addLineToPoint(CGPointMake(23.4, 36.18))
      bezierPath.addCurveToPoint(CGPointMake(27.77, 35.27), controlPoint1: CGPointMake(24.82, 37.59), controlPoint2: CGPointMake(27.77, 35.27))
      bezierPath.addLineToPoint(CGPointMake(27.63, 35.12))
      bezierPath.addCurveToPoint(CGPointMake(30.16, 36.2), controlPoint1: CGPointMake(28.42, 35.58), controlPoint2: CGPointMake(29.26, 35.95))
      bezierPath.addCurveToPoint(CGPointMake(32.68, 40), controlPoint1: CGPointMake(30.31, 36.81), controlPoint2: CGPointMake(31.15, 40))
      bezierPath.addLineToPoint(CGPointMake(33.36, 40))
      bezierPath.addCurveToPoint(CGPointMake(35.86, 36.27), controlPoint1: CGPointMake(35.36, 40), controlPoint2: CGPointMake(35.86, 36.27))
      bezierPath.addLineToPoint(CGPointMake(35.67, 36.27))
      bezierPath.addCurveToPoint(CGPointMake(38.23, 35.24), controlPoint1: CGPointMake(36.58, 36.03), controlPoint2: CGPointMake(37.44, 35.69))
      bezierPath.addCurveToPoint(CGPointMake(42.52, 36.25), controlPoint1: CGPointMake(38.86, 35.65), controlPoint2: CGPointMake(41.47, 37.29))
      bezierPath.addLineToPoint(CGPointMake(43.21, 35.55))
      bezierPath.addCurveToPoint(CGPointMake(42.27, 31.23), controlPoint1: CGPointMake(44.6, 34.16), controlPoint2: CGPointMake(42.34, 31.31))
      bezierPath.addCurveToPoint(CGPointMake(43.29, 28.81), controlPoint1: CGPointMake(42.7, 30.48), controlPoint2: CGPointMake(43.05, 29.67))
      bezierPath.addCurveToPoint(CGPointMake(47, 26.31), controlPoint1: CGPointMake(44.07, 28.61), controlPoint2: CGPointMake(47, 27.77))
      bezierPath.addLineToPoint(CGPointMake(47, 25.63))
      bezierPath.addCurveToPoint(CGPointMake(43.29, 23.14), controlPoint1: CGPointMake(47, 23.69), controlPoint2: CGPointMake(43.51, 23.17))
      bezierPath.closePath()
      bezierPath.moveToPoint(CGPointMake(33, 33.88))
      bezierPath.addCurveToPoint(CGPointMake(25.12, 26), controlPoint1: CGPointMake(28.65, 33.88), controlPoint2: CGPointMake(25.12, 30.35))
      bezierPath.addCurveToPoint(CGPointMake(33, 18.12), controlPoint1: CGPointMake(25.12, 21.65), controlPoint2: CGPointMake(28.65, 18.12))
      bezierPath.addCurveToPoint(CGPointMake(40.88, 26), controlPoint1: CGPointMake(37.35, 18.12), controlPoint2: CGPointMake(40.88, 21.65))
      bezierPath.addCurveToPoint(CGPointMake(33, 33.88), controlPoint1: CGPointMake(40.88, 30.35), controlPoint2: CGPointMake(37.35, 33.88))
      bezierPath.closePath()
      bezierPath.miterLimit = 4;
      
      darkTertiary.setFill()
      bezierPath.fill()


    }

}
