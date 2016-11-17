//
//  TableViewCell.swift
//  NimGame
//
//  Created by imac on 14/11/2016.
//  Copyright © 2016 laurent. All rights reserved.
//

import UIKit

class TableViewCell: UITableViewCell {

    @IBOutlet weak var ui_playerNameLabel: UILabel!
    @IBOutlet weak var ui_playerScoreLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
