import CoreGraphics
import QuartzCore
import UIKit

class AddExtButton : UIButton {
  var line1: CAShapeLayer! = CAShapeLayer()
  var line2: CAShapeLayer! = CAShapeLayer()
  
  let stroke: CGPath = {
    let path = CGPathCreateMutable()
    CGPathMoveToPoint(path, nil, 2, 2)
    CGPathAddLineToPoint(path, nil, 28, 2)
    
    return path
  }()
  
  required init(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)!
  }
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    
    
    self.line1.path = stroke
    self.line2.path = stroke
    
    for layer in [ self.line1, self.line2 ] {
      layer.fillColor = nil
      layer.strokeColor = UIColor(red: 0.984, green: 0.153, blue: 0.247, alpha: 1.000).CGColor
      layer.lineWidth = 4
      layer.miterLimit = 4
      layer.lineCap = kCALineCapRound
      layer.masksToBounds = true
      
      let strokingPath = CGPathCreateCopyByStrokingPath(layer.path, nil, 4, .Round, .Miter, 4)
      
      layer.bounds = CGPathGetPathBoundingBox(strokingPath)
      
      self.layer.addSublayer(layer)
    }

    self.line1.setAffineTransform(CGAffineTransformMakeRotation(90  * CGFloat(M_PI) / 180.0))
    self.line1.anchorPoint = CGPointMake(0.5, 0.5)
    self.line1.position = CGPointMake(self.layer.frame.width / 2, self.layer.frame.height / 2)
    
    
    self.line2.anchorPoint = CGPointMake(0.5, 0.5)
    self.line2.position = CGPointMake(self.layer.frame.width / 2, self.layer.frame.height / 2)
    
  }
}