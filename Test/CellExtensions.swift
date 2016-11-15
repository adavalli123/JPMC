import UIKit

extension UITableViewCell {
    override public func awakeFromNib() {
        super.awakeFromNib()
        self.layoutMargins = UIEdgeInsetsZero
    }
}
