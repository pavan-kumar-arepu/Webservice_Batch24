//
//  MarketTableViewCell.swift
//  Market
//
//  Created by Pavankumar Arepu on 19/10/2021.
//

import UIKit

class MarketTableViewCell: UITableViewCell {

    @IBOutlet weak var secondLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var price: UILabel!
    @IBOutlet weak var volume: UILabel!
    @IBOutlet weak var timestamp: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
