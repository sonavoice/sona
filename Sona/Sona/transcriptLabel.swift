import Foundation

@IBDesignable class TopAlignedLabel: UILabel {
  override func drawTextInRect(rect: CGRect) {
    if let stringText = text {
      let stringTextAsNSString = stringText as NSString
      var labelStringSize = stringTextAsNSString.boundingRectWithSize(CGSizeMake(CGRectGetWidth(self.frame), CGFloat.max),
        options: NSStringDrawingOptions.UsesLineFragmentOrigin,
        attributes: [NSFontAttributeName: font],
        context: nil).size
      super.drawTextInRect(CGRectMake(0, 0, CGRectGetWidth(self.frame), ceil(labelStringSize.height)))
    } else {
      super.drawTextInRect(rect)
    }
  }
  override func prepareForInterfaceBuilder() {
    super.prepareForInterfaceBuilder()
    self.numberOfLines = 0
    self.lineBreakMode = .ByWordWrapping
  }
}
