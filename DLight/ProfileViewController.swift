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
    
    // @IBOutlet weak var myTable: UITableView!
    var myTable: UITableView!
    var scroller: UIScrollView!
    let cellHeight: CGFloat = 80
    var width: CGFloat!
    var height: CGFloat!
    /*
    private let keys = ["name", "age", "diabetic status", "intake restrictions",
                        "dietary restrictions", "activity level"]
    private let dummyData: [String: Any] = ["name": "Bob Dylan", "age": 42,
                             "diabetic status": 2, "intake restrictions": "Low Sodium",
                            "dietary restrictions": "No Pork", "activity level": 5]
    */
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
        let tableHeight:CGFloat = CGFloat(bobKeys.count) * cellHeight
        scroller = UIScrollView(frame: CGRect(x: 0, y: 0, width: width, height: height))
        scroller.contentSize = CGSizeMake(width, 200+0.8*cellHeight+tableHeight)
        scroller.delegate = self
        view.addSubview(scroller)
        
        let image = UIImage(named: "person_wide")
        let imageFrame = UIImageView(image: image)
        imageFrame.frame = CGRect(x: 0, y: 0, width: width, height: 200)
        scroller.addSubview(imageFrame)
        
        myTable = UITableView(frame: CGRect(x: 0, y: 200, width: width, height: tableHeight))
        myTable.rowHeight = cellHeight
        myTable.userInteractionEnabled = false
        myTable.registerClass(MProfileCell.self, forCellReuseIdentifier: "cell")
        myTable.delegate = self
        myTable.dataSource = self
        myTable.allowsSelection = false
        scroller.addSubview(myTable)
        //view.addSubview(myTable)
        
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
        let cell = myTable.dequeueReusableCellWithIdentifier("cell", forIndexPath: indexPath) as! MProfileCell
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
        // performSegueWithIdentifier("TableToDetail", sender: self)
        return indexPath
    }
    


}
