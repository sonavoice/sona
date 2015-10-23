import UIKit

class CellView: UITableViewCell {
  
  @IBOutlet var Name: UILabel!
  @IBOutlet var Detail: UILabel!
  @IBOutlet var AppIcon: UIImageView!
  
  override func awakeFromNib() {
    super.awakeFromNib()
  }
  
  override func setSelected(selected: Bool, animated: Bool) {
    super.setSelected(selected, animated: animated)
  }
}