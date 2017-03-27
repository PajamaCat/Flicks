//
//  UserCellTableViewCell.swift
//  Flicks
//
//  Created by jiafang_jiang on 3/21/17.
//  Copyright © 2017 jiafang_jiang. All rights reserved.
//

import UIKit

class MovieCellTableViewCell: UITableViewCell {


  @IBOutlet weak var titleLabel: UILabel!
  @IBOutlet weak var overviewLabel: UILabel!
  @IBOutlet weak var movieImageView: UIImageView!

  @IBOutlet weak var overviewScrollView: UIScrollView!
  
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
