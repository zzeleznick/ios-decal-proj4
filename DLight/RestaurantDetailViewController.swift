//
//  RestaurantDetailViewController.swift
//  DLight
//
//  Created by Zach Zeleznick on 4/24/16.
//  Copyright © 2016 zzeleznick. All rights reserved.
//

import Foundation
import UIKit

class RestaurantDetailViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UIScrollViewDelegate {
    
    var myTable: UITableView!
    var scroller: UIScrollView!
    let cellHeight: CGFloat = 80
    let imageHeight: CGFloat = 250
    var width: CGFloat!
    var height: CGFloat!
    
    var restaurant: Restaurant!
    var keys: [String]!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Custom Set-up
        keys = [String](restaurant.dict.keys)
        keys.sortInPlace()
        
        // Programatic Methods
        view = UIView(frame: UIScreen.mainScreen().bounds)
        view.backgroundColor = UIColor(white: 0.9, alpha: 1.0)
        navigationItem.title = restaurant.name
        width = UIScreen.mainScreen().bounds.size.width
        height = UIScreen.mainScreen().bounds.size.height
        let tableHeight:CGFloat = CGFloat(keys.count) * cellHeight + 10
        scroller = UIScrollView(frame: CGRect(x: 0, y: 0, width: width, height: height))
        scroller.contentSize = CGSizeMake(width, imageHeight+0.8*cellHeight+tableHeight)
        scroller.delegate = self
        view.addSubview(scroller)
        
        let image = UIImage(named: "CaffeOrganica")
        let imageFrame = UIImageView(image: image)
        imageFrame.frame = CGRect(x: 0, y: 0, width: width, height: imageHeight)
        scroller.addSubview(imageFrame)
        
        myTable = UITableView(frame: CGRect(x: 0, y: imageHeight, width: width, height: tableHeight))
        myTable.rowHeight = cellHeight
        myTable.userInteractionEnabled = false
        myTable.registerClass(KVCell.self, forCellReuseIdentifier: "cell")
        myTable.delegate = self
        myTable.dataSource = self
        myTable.allowsSelection = false
        scroller.addSubview(myTable)
        // End Programatic Methods
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return keys.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let idx = indexPath.row
        let cell = myTable.dequeueReusableCellWithIdentifier("cell", forIndexPath: indexPath) as! KVCell
        let key = keys[idx]
        cell.keyLabel.text = key.capitalizedString
        if let value = restaurant.dict[key] {
            cell.valueLabel.text = "\(value)"
        }
        cell.setBounds()
        return cell
    }
    
    func tableView(tableView: UITableView, willSelectRowAtIndexPath indexPath: NSIndexPath) -> NSIndexPath? {
        print("User will tap \(indexPath.row)")
        return indexPath
    }
    
    
}