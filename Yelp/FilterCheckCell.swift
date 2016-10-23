//
//  FilterCheckCell.swift
//  Yelp
//
//  Created by Developer on 10/22/16.
//  Copyright © 2016 Timothy Lee. All rights reserved.
//

import UIKit

class FilterCheckCell: UITableViewCell {

    @IBOutlet weak var filterLabel: UILabel!
    @IBOutlet weak var checkButton: UIButton!
    
    var distanceEnum:FilterDistanceBy = FilterDistanceBy.close
    var sortEnum:FilterSortBy = FilterSortBy.bastMatch
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        self.checkButton.isSelected = selected
        // Configure the view for the selected state
    }

}
