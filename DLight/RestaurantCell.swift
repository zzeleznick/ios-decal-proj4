//
//  RestaurantCell.swift
//  DLight
//
//  Created by Zach Zeleznick on 3/15/16.
//  Copyright © 2016 zzeleznick. All rights reserved.
//

import UIKit

class RestaurantCell: UITableViewCell {
    
    
    @IBOutlet weak var nameLabel: UILabel!
    
    @IBOutlet weak var locationLabel: UILabel!

    @IBOutlet weak var myImage: UIImageView!
    
  
    override func awakeFromNib() {
        super.awakeFromNib()
        nameLabel.textColor = UIColor(white: 0.95, alpha: 1.0)
        nameLabel.font = UIFont(name: Theme.fontBoldName, size: Theme.titleSize)
        locationLabel.textColor = UIColor(white: 0.95, alpha: 1.0)
        locationLabel.font = UIFont(name: Theme.fontName, size: Theme.titleSize)
    }
    
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
}