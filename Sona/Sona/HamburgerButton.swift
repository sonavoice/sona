import CoreGraphics
import QuartzCore
import UIKit

class HamburgerButton : UIButton {
  let shortStroke: CGPath = {
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
    
    self.addTarget(self, action: "toggle:", forControlEvents: .TouchUpInside)
    
    self.top.path = shortStroke
    self.middle.path = shortStroke
    self.bottom.path = shortStroke
    
    for layer in [ self.top, self.middle, self.bottom ] {
      layer.fillColor = nil
      layer.strokeColor = UIColor(red: 0.984, green: 0.153, blue: 0.247, alpha: 1.000).CGColor
      layer.lineWidth = 4
      layer.miterLimit = 4
      layer.lineCap = kCALineCapRound
      layer.masksToBounds = true
      
//      CGPathCreateCopyByStrokingPath
      let strokingPath = CGPathCreateCopyByStrokingPath(layer.path, nil, 4, .Round, .Miter, 4)
      
      layer.bounds = CGPathGetPathBoundingBox(strokingPath)
      
      layer.actions = [
        "transform": NSNull()
      ]
      
      self.layer.addSublayer(layer)
    }
    
    self.top.anchorPoint = CGPointMake(28.0 / 30.0, 0.5)
    self.top.position = CGPointMake(40, 18)
    
    self.middle.position = CGPointMake(27, 27)
    
    self.bottom.anchorPoint = CGPointMake(28.0 / 30.0, 0.5)
    self.bottom.position = CGPointMake(40, 36)
  }
  
  var showsMenu: Bool = false {
    didSet {

      let middleTransform = CABasicAnimation(keyPath: "opacity")
      middleTransform.fillMode = kCAFillModeBackwards
      middleTransform.removedOnCompletion = false
      middleTransform.beginTime = CACurrentMediaTime()
      
      let topTransform = CABasicAnimation(keyPath: "transform")
      topTransform.timingFunction = CAMediaTimingFunction(controlPoints: 0.5, -0.8, 0.5, 1.85)
      topTransform.duration = 0.4
      topTransform.fillMode = kCAFillModeBackwards
      topTransform.beginTime = CACurrentMediaTime() + 0.05
      
      let bottomTransform = topTransform.copy() as! CABasicAnimation
      
      if self.showsMenu {
        let translation = CATransform3DMakeTranslation(-4, 0, 0)
        
        topTransform.toValue = NSValue(CATransform3D: CATransform3DRotate(translation, -0.7853975, 0, 0, 1))
        
        bottomTransform.toValue = NSValue(CATransform3D: CATransform3DRotate(translation, 0.7853975, 0, 0, 1))
        
        middleTransform.fromValue = 1.0
        middleTransform.toValue = 0.0
        middleTransform.timingFunction = CAMediaTimingFunction(controlPoints: 0.5, -0.8, 0.5, 1.85)
      } else {
        topTransform.toValue = NSValue(CATransform3D: CATransform3DIdentity)
        
        bottomTransform.toValue = NSValue(CATransform3D: CATransform3DIdentity)
        
        middleTransform.toValue = 1.0
        middleTransform.timingFunction = CAMediaTimingFunction(controlPoints: 0.1, -0.8, 0.1, 1.85)
      }
      
      self.top.applyAnimation(topTransform)
      self.middle.applyAnimation(middleTransform)
      self.bottom.applyAnimation(bottomTransform)
    }
  }
  
  var top: CAShapeLayer! = CAShapeLayer()
  var bottom: CAShapeLayer! = CAShapeLayer()
  var middle: CAShapeLayer! = CAShapeLayer()
  
  func toggle(sender: AnyObject!) {
    self.showsMenu = !self.showsMenu
  }
  
}

extension CALayer {
  func applyAnimation(animation: CABasicAnimation) {
    let copy = animation.copy() as! CABasicAnimation
    
    if copy.fromValue == nil {
      copy.fromValue = self.presentationLayer()!.valueForKeyPath(copy.keyPath!)
    }
    
    self.addAnimation(copy, forKey: copy.keyPath)
    self.setValue(copy.toValue, forKeyPath:copy.keyPath!)
  }
}
