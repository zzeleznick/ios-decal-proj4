//
//  NutritionCell.swift
//  DLight
//
//  Created by Zach Zeleznick on 4/23/16.
//  Copyright © 2016 zzeleznick. All rights reserved.
//

import Foundation
import UIKit

class NutritionCell: UITableViewCell {
    
    let mainLabel = UILabel() // Nutrition Header
    // let keys = ["Calories", "Carbs", "Protein", "Sugar", "Fat"]
    var keyLabels = [UILabel]()
    var valueLabels = [UILabel]()
    
    func populate(nutrition: Nutrition) {
        let w = frame.size.width
        let h = frame.size.height
        let myKeys = [String](nutrition.dict.keys)
        let itemHeight:CGFloat = 15
        let totalHeight = itemHeight * CGFloat(2 * myKeys.count)
        mainLabel.frame = CGRect(x: 0, y: 5, width: w, height: 20)
        mainLabel.text = "Nutrition Facts"
        contentView.addSubview(mainLabel)
        for i in 0..<myKeys.count {
            let key = myKeys[i]
            let value = nutrition.dict[key]
            let keyFrame = CGRect(x: 0, y: itemHeight*CGFloat(2*i+1),
                        width: w, height: itemHeight)
            let valueFrame = CGRect(x: 10, y: itemHeight*CGFloat(2*i+2),
                width: w, height: itemHeight)
            keyLabels.append(UILabel(frame: keyFrame))
            valueLabels.append(UILabel(frame: valueFrame))
            keyLabels[i].text = key
            valueLabels[i].text = value
            contentView.addSubview(keyLabels[i])
            contentView.addSubview(valueLabels[i])
        }
    }
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
    }
    
    required init?(coder aDecoder: NSCoder) {
        /* NOTE:
        * Need this special init and cannot use awake from Nib for pure programmatic
        * http://randexdev.com/2014/08/uicollectionviewcell/
        */
        fatalError("init(coder:) has not been implemented")
    }
}