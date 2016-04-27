//
//  MRestaurantCell.swift
//  DLight
//
//  Created by Zach Zeleznick on 4/26/16.
//  Copyright © 2016 zzeleznick. All rights reserved.
//
import Foundation
import UIKit

class MRestaurantCell: UITableViewCell {
    
    let myImageView = UIImageView()
    let nameLabel = UILabel()
    let locationLabel = UILabel()
    
    func setBounds() {
        // let screenWidth = UIScreen.mainScreen().bounds.size.width
        let w = frame.size.width
        let h = frame.size.height
        print(w,h)
        nameLabel.frame = CGRect(x: 10, y: h-30, width: w/2-10, height: 20)
        locationLabel.frame = CGRect(x: w/2, y: h-30, width: w/2-10, height: 20)
        myImageView.frame = CGRect(x: 0, y: 0, width: w, height: h)
        myImageView.backgroundColor = UIColor.blueColor()
        imageView?.backgroundColor = UIColor.brownColor()
        myImageView.contentMode = .ScaleAspectFill
    }
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        nameLabel.textColor = UIColor(white: 0.25, alpha: 1.0)
        nameLabel.font = UIFont(name: Theme.fontBoldName, size: Theme.titleSize)
        
        locationLabel.textColor = UIColor(white: 0.25, alpha: 1.0)
        locationLabel.font = UIFont(name: Theme.fontName, size: Theme.titleSize)
        contentView.didAddSubview(myImageView)
        contentView.addSubview(nameLabel)
        contentView.addSubview(locationLabel)
        self.setBounds()
    }
    
    required init?(coder aDecoder: NSCoder) {
        /* NOTE:
        * Need this special init and cannot use awake from Nib for pure programmatic
        * http://randexdev.com/2014/08/uicollectionviewcell/
        */
        fatalError("init(coder:) has not been implemented")
    }
}