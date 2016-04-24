//
//  MProfileViewController.swift
//  DLight
//
//  Created by Zach Zeleznick on 4/23/16.
//  Copyright © 2016 zzeleznick. All rights reserved.
//
import UIKit

class MProfileViewController: UIViewController, UITableViewDelegate, UITableViewDataSource,
UIScrollViewDelegate {
    
    var myTable: UITableView!
    var scroller: UIScrollView!
    let cellHeight: CGFloat = 80
    let imageHeight: CGFloat = 250
    var width: CGFloat!
    var height: CGFloat!

    let Bob = Profile(name:"Bob Dylan", age: 42, diabetes: 2, activity: 0,intakeRestrictions: ["Low Sodium"], dietaryRestrictions: ["No Pork"])
    
    var bobKeys: [String]!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        bobKeys = [String](Bob.dict.keys)
        bobKeys.sortInPlace()
        
        // Programatic Methods
        view = UIView(frame: UIScreen.mainScreen().bounds)
        view.backgroundColor = UIColor(white: 0.9, alpha: 1.0)
        navigationItem.title = "Profile"
        width = UIScreen.mainScreen().bounds.size.width
        height = UIScreen.mainScreen().bounds.size.height
        let tableHeight:CGFloat = CGFloat(bobKeys.count) * cellHeight + 10
        scroller = UIScrollView(frame: CGRect(x: 0, y: 0, width: width, height: height))
        scroller.contentSize = CGSizeMake(width, imageHeight+0.8*cellHeight+tableHeight)
        scroller.delegate = self
        view.addSubview(scroller)
        
        let image = UIImage(named: "person_wide")
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
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // Returning to view
    override func viewWillAppear(animated: Bool) {
        myTable.reloadData()
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Bob.dict.count
    }
    
    func tableView(tableView: UITableView, didDeselectRowAtIndexPath indexPath: NSIndexPath) {
        print("User did tap \(indexPath.row)")
    }
    
    /*
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
    return cellHeight
    }*/
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let idx = indexPath.row
        let cell = myTable.dequeueReusableCellWithIdentifier("cell", forIndexPath: indexPath) as! KVCell
        let key = bobKeys[idx]
        cell.keyLabel.text = key.capitalizedString
        if let value = Bob.dict[key] {
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
