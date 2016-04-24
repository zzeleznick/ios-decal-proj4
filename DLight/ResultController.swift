//
//  ResultController.swift
//  DLight
//
//  Created by Zach Zeleznick on 3/15/16.
//  Copyright © 2016 zzeleznick. All rights reserved.
//

import UIKit
import CoreData

class ResultController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var myTable: UITableView!
    private let names = ["Restaurant 1", "Restaurant 2", "Restaurant 3",
                        "Cafe 1", "Cafe 2", "Cafe 3"]
    private let locations = ["2258 Haste St", "2190 Haste St", "2054 Durant Ave",
                        "2050 Durant Ave", "1950 Durant Ave", "1600 Telegraph Ave"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
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
        return names.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let idx = indexPath.row
        let cell = myTable.dequeueReusableCellWithIdentifier("cell", forIndexPath: indexPath) as! RestaurantCell
        
        let name = names[idx]
        let loc = locations[idx]
        cell.nameLabel.text = name
        cell.locationLabel.text = loc
        cell.nameLabel.textColor = UIColor(white:0, alpha: 1.0)
        cell.locationLabel.textColor = UIColor(white:0, alpha: 1.0)
        cell.locationLabel.font = UIFont(name: Theme.fontName, size: Theme.titleSize)
        cell.nameLabel.font = UIFont(name: Theme.fontName, size: Theme.titleSize)
        cell.selectionStyle = UITableViewCellSelectionStyle.None
        return cell
    }
    
    func tableView(tableView: UITableView, willSelectRowAtIndexPath indexPath: NSIndexPath) -> NSIndexPath? {
        print("User will tap \(indexPath.row)")
        // performSegueWithIdentifier("TableToDetail", sender: self)
        return indexPath
    }
    
    
}