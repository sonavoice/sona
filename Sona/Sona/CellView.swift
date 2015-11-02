import UIKit

class CellView: UITableViewCell {
  
  @IBOutlet weak var arrow: UILabel!
  @IBOutlet weak var icon: UIImageView!
  @IBOutlet weak var name: UILabel!
  override func awakeFromNib() {
    super.awakeFromNib()
  }
  
  override func setSelected(selected: Bool, animated: Bool) {
    super.setSelected(selected, animated: animated)
  }
  
  
}