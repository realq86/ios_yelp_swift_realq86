//
//  FilterViewCell.swift
//  Yelp
//
//  Created by Developer on 10/20/16.
//  Copyright © 2016 Timothy Lee. All rights reserved.
//

import UIKit

@objc protocol FilterViewCellDelegate {
//    @objc optional func userDidChangeFilter(cell:FilterViewCell, toValue:Bool)
    @objc optional func userDidChange(tableView:UITableView, for cell:FilterViewCell, to value:Bool)
}

class FilterViewCell: UITableViewCell {

    @IBOutlet weak var filterLabel: UILabel!
    
    @IBOutlet weak var filterSwitch: UISwitch!
    
    var delegate:FilterViewCellDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        self.filterSwitch .addTarget(self, action: #selector(switchValueChanged(sender:)), for: .valueChanged)
        
    }
    
    func switchValueChanged(sender:UISwitch) {
        print("Switch \(filterLabel.text) Changed to \(sender.isOn)")
    //        self.delegate?.userDidChangeFilter!(cell: self, toValue: self.filterSwitch.isOn)
        
        if let currentTableView = self.getTableViewOf(view: self) {
            self.delegate?.userDidChange!(tableView: currentTableView, for: self, to: self.filterSwitch.isOn)
        }
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    override func prepareForReuse() {
        self.filterLabel.text = ""
        self.filterSwitch.isOn = false
    }

    func getTableViewOf(view:UIView) -> UITableView? {
        
        guard let superView = view.superview
            else {
                return nil
        }
        if superView is UITableView {
            return superView as? UITableView
        }
        else {
            return self.getTableViewOf(view: superView)
        }
    }
    
    
}
