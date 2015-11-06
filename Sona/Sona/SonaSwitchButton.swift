import Foundation

@IBDesignable
class SonaSwitchButton: UISwitch {
  override init(frame: CGRect) {
    super.init(frame: frame)
  }
  
  required init(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)!
  }
  
  override func drawRect(rect: CGRect) {
    self.onTintColor = UIColor(red: 1.000, green: 0.725, blue: 0.753, alpha: 1.000)
  }
}
