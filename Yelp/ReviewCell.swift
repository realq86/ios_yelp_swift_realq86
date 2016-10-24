//
//  ReviewCell.swift
//  Yelp
//
//  Created by Developer on 10/23/16.
//  Copyright © 2016 Timothy Lee. All rights reserved.
//

import UIKit

class ReviewCell: UITableViewCell {

    @IBOutlet weak var reviewImage: UIImageView!
    
    
    @IBOutlet weak var reviewCount: UILabel!
    
    @IBOutlet weak var reviewSnip: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
