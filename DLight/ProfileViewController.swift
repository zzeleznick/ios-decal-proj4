//
//  ProfileViewController.swift
//  DLight
//
//  Created by Zach Zeleznick on 3/15/16.
//  Copyright © 2016 zzeleznick. All rights reserved.
//

import UIKit

class ProfileViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var myTable: UITableView!
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
        // Do any additional setup after loading the view, typically from a nib.
         bobKeys = [String](Bob.dict.keys)
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
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let idx = indexPath.row
        let cell = myTable.dequeueReusableCellWithIdentifier("cell", forIndexPath: indexPath) as! ProfileCell
        
        let key = bobKeys[idx]
        cell.keyLabel.text = key.capitalizedString
        if let value = Bob.dict[key] {
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
