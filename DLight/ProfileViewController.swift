//
//  ProfileViewController.swift
//  DLight
//
//  Created by Zach Zeleznick on 3/15/16.
//  Copyright © 2016 zzeleznick. All rights reserved.
//

import UIKit

class ProfileViewController: UIViewController, UITableViewDelegate, UITableViewDataSource,
UIScrollViewDelegate {
    
    @IBOutlet weak var myTable: UITableView!
    private let keys = ["name", "age", "diabetic status", "intake restrictions",
                        "dietary restrictions", "activity level"]
    private let dummyData: [String: Any] = ["name": "Bob Dylan", "age": 42,
                             "diabetic status": 2, "intake restrictions": "Low Sodium",
                            "dietary restrictions": "No Pork", "activity level": 5]
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    // Returning to view
    override func viewWillAppear(animated: Bool) {
        myTable.reloadData()
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return keys.count
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
        let cell = myTable.dequeueReusableCellWithIdentifier("cell", forIndexPath: indexPath) as! ProfileCell
        let key = keys[idx]
        cell.keyLabel.text = key.capitalizedString
        if let value = dummyData[key] {
            cell.valueLabel.text = "\(value)"
        }
        return cell
    }
    
    func tableView(tableView: UITableView, willSelectRowAtIndexPath indexPath: NSIndexPath) -> NSIndexPath? {
        print("User will tap \(indexPath.row)")
        // performSegueWithIdentifier("TableToDetail", sender: self)
        return indexPath
    }
    

}
