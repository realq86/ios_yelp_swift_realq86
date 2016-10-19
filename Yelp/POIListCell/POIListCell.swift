//
//  POIListCell.swift
//  Yelp
//
//  Created by Developer on 10/18/16.
//  Copyright © 2016 Timothy Lee. All rights reserved.
//

import UIKit

class POIListCell: UITableViewCell {
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var backgroundImageView: UIImageView!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    
    override func prepareForReuse() {
        self.titleLabel.text = ""
        self.backgroundImageView.image = nil
    }
}
