//
//  NewsTVC.swift
//  NewsApp
//
//  Created by Aakash Decosta on 13/07/22.
//

import UIKit
import SDWebImage

class NewsTVC: UITableViewCell {

    @IBOutlet weak var blurView: UIView!
    @IBOutlet weak var newsTitle: UILabel!
    @IBOutlet weak var newsImage: UIImageView!
    var cellData: NewArticle? {
        didSet {
            let userPlaceholder = UIImage(named: "new_placeholder")
            let imageUrl = URL(string: cellData?.urlToImage ?? "")
            newsImage.sd_setImage(with: imageUrl , placeholderImage:  userPlaceholder)
            newsTitle.text = cellData?.title
        }
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        selectionStyle = .none
    }
    

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
