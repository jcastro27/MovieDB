//
//  MovieTableViewCell.swift
//  MovieDB1.2
//
//  Created by Joseph Castro on 5/23/22.
//

import UIKit

class MovieTableViewCell: UITableViewCell {
    @IBOutlet weak var MovieImgView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var releaseLable: UILabel!
    @IBOutlet weak var contentLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
   

}
