//
//  MenuViewController.swift
//  DLight
//
//  Created by Zach Zeleznick on 4/26/16.
//  Copyright © 2016 zzeleznick. All rights reserved.
//

import UIKit

class MenuViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UIScrollViewDelegate {
    
    var myTable: UITableView!
    var scroller: UIScrollView!
    let cellHeight: CGFloat = 80
    let imageHeight: CGFloat = 250
    var width: CGFloat!
    var height: CGFloat!
    
    let viewMenuButton = UIButton()
    
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
        
        let image = restaurant.image //UIImage(named: "CaffeOrganica")
        let imageFrame = UIImageView(image: image)
        imageFrame.frame = CGRect(x: 0, y: 0, width: width, height: imageHeight)
        scroller.addSubview(imageFrame)
        
        viewMenuButton.frame = CGRect(x: width/2-50, y: imageHeight-40, width: 100, height: 40)
        viewMenuButton.setTitle("View Menu", forState: .Normal)
        viewMenuButton.setTitleColor(UIColor(white: 0.95, alpha: 1.0), forState: .Normal)
        viewMenuButton.backgroundColor = UIColor(white: 0, alpha: 0.7)
        viewMenuButton.addTarget(self, action: "applyTransition", forControlEvents: UIControlEvents.TouchUpInside)
        scroller.addSubview(viewMenuButton)
        
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
    func applyTransition() {
        let dest = MDishViewController()
        dest.view.backgroundColor = UIColor(white: 0.9, alpha: 1.0)
        navigationController?.pushViewController(dest, animated: true)
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