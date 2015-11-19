//
//  ConversationCell.swift
//  Sona
//
//  Created by Marcus Buffett on 11/19/15.
//  Copyright © 2015 Sona. All rights reserved.
//

import UIKit

class ConversationCell: UITableViewCell {
  
  var msgLabel : UILabel!
  var isUser : Bool = false
  
  override func awakeFromNib() {
    super.awakeFromNib()
    // Initialization code
  }
  
  
  override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
    super.init(style: style, reuseIdentifier: reuseIdentifier)
    
    self.msgLabel = UILabel(frame: CGRectZero)
    self.msgLabel.textAlignment = .Left
    self.msgLabel.textColor = UIColor.blackColor()
    
    contentView.addSubview(msgLabel)
  }
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  
  override func setSelected(selected: Bool, animated: Bool) {
    super.setSelected(selected, animated: animated)
    
    // Configure the view for the selected state
  }
  
  override func layoutSubviews() {
    self.msgLabel.frame = CGRectMake(0, 0, self.frame.width, self.frame.height)
    if (isUser) {
      self.msgLabel.textAlignment = .Right
    }
    else {
      self.msgLabel.textAlignment = .Left
    }
  }
  
  func setMsg(msg: String) {
    self.msgLabel.text = msg
  }
  
}
