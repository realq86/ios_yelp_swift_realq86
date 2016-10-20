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
    @IBOutlet weak var catagoryLabel: UILabel!
    @IBOutlet weak var addressLabel: UILabel!
    @IBOutlet weak var starRatingImageView: UIImageView!
    @IBOutlet weak var ratingsCountLabel: UILabel!
    @IBOutlet weak var distanceLabel: UILabel!

    var business:Business? {
        didSet {
            self.titleLabel.text = self.business?.name
            if let imageURL = self.business?.imageURL {
                self.backgroundImageView.setImageWith(imageURL, placeholderImage: nil)
                print(imageURL)
            }
            
            if let ratingImageURL = self.business?.ratingImageURL {
                self.starRatingImageView.setImageWith(ratingImageURL)
            }
            
            self.catagoryLabel.text = self.business?.categories
            self.addressLabel.text = self.business?.address
            self.ratingsCountLabel.text = (self.business?.reviewCount?.stringValue)! + " reviews"
            self.distanceLabel.text = self.business?.distance
        }
    }
    
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
