//
//  FilterViewCell.swift
//  Yelp
//
//  Created by Developer on 10/20/16.
//  Copyright © 2016 Timothy Lee. All rights reserved.
//

import UIKit

class FilterViewCell: UITableViewCell {

    @IBOutlet weak var filterLabel: UILabel!
    
    @IBOutlet weak var filterSwitch: UISwitch!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    override func prepareForReuse() {
        self.filterLabel.text = ""
        self.filterSwitch.isOn = false
    }

}
