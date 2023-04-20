import UIKit

class ListViewTableViewCell: UITableViewCell {

  @IBOutlet var nameLabel: UILabel!
  @IBOutlet var rateLabel: UILabel!

  static let identifier = "ListViewTableViewCell"
  
    override func awakeFromNib() {
        super.awakeFromNib()
    }
  
  func configureWith(dataNameCoin: String,
                     dataNameRate: String) {
    DispatchQueue.main.async {
      self.nameLabel.text = dataNameCoin
      self.rateLabel.text = dataNameRate
    }
  }
    
}
