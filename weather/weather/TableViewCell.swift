//
//  TableViewCell.swift
//  weather
//
//  Created by user on 22/11/2020.
//

import UIKit


class TableViewCell: UITableViewCell {


@IBOutlet weak var backgroundCell: UIImageView!

@IBOutlet weak var time: UILabel!

@IBOutlet weak var nameCity: UILabel!

@IBOutlet weak var temp: UILabel!

@IBOutlet weak var icon: UIImageView!

override func awakeFromNib() {
    super.awakeFromNib()
    // Initialization code
}

override func setSelected(_ selected: Bool, animated: Bool) {
    super.setSelected(selected, animated: animated)

    // Configure the view for the selected state
}

}
