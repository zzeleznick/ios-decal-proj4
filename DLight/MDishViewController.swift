//
//  MDishViewController.swift
//  DLight
//
//  Created by Zach Zeleznick on 4/23/16.
//  Copyright © 2016 zzeleznick. All rights reserved.
//

//
//  DishViewController.swift
//  DLight
//
//  Created by Zach Zeleznick on 3/15/16.
//  Copyright © 2016 zzeleznick. All rights reserved.
//

import UIKit

class MDishViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UIScrollViewDelegate {
    
    var myTable: UITableView!
    var scroller: UIScrollView!
    let cellHeight: CGFloat = 80
    let nutritionHeight: CGFloat = 0//200
    let imageHeight: CGFloat = 250
    var width: CGFloat!
    var height: CGFloat!
    let nextButton = UIButton()
    let prevButton = UIButton()
    
    var index = 0
    var dish: Dish!
    var dishes: [Dish] = generateSampleMenu().dishes
    var dishKeys: [String]!

    override func viewDidLoad() {
        super.viewDidLoad()
        dish = dishes[index]
        dishKeys = [String](dish.dict.keys)
        let nutritionKeys = [String](dish.nutrition.dict.keys)
        for key in nutritionKeys {
             dishKeys.append(key)
        }
        dishKeys.sortInPlace()
        
        // Programatic Methods
        view = UIView(frame: UIScreen.mainScreen().bounds)
        view.backgroundColor = UIColor(white: 0.9, alpha: 1.0)
        navigationItem.title = dish.name // "Dish"
        width = UIScreen.mainScreen().bounds.size.width
        height = UIScreen.mainScreen().bounds.size.height
        
        let tableHeight:CGFloat = CGFloat(dishKeys.count) * cellHeight + 10 + nutritionHeight
        
        scroller = UIScrollView(frame: CGRect(x: 0, y: 0, width: width, height: height))
        scroller.contentSize = CGSizeMake(width, imageHeight+0.8*cellHeight+tableHeight)
        scroller.delegate = self
        view.addSubview(scroller)
        
        let image = dish.merchant.photo! //UIImage(named: "salmon_wide")
        let imageFrame = UIImageView(image: image)
        imageFrame.frame = CGRect(x: 0, y: 0, width: width, height: imageHeight)
        scroller.addSubview(imageFrame)
        
        nextButton.frame = CGRect(x: 3*width/4, y: imageHeight-40, width: width/4, height: 40)
        prevButton.frame = CGRect(x: 0, y: imageHeight-40, width: width/4, height: 40)
        nextButton.setTitle("Next", forState: .Normal)
        prevButton.setTitle("Previous", forState: .Normal)
        nextButton.addTarget(self, action: "nextDish", forControlEvents: UIControlEvents.TouchUpInside)
        prevButton.addTarget(self, action: "prevDish", forControlEvents: UIControlEvents.TouchUpInside)
        nextButton.setTitleColor(UIColor(white: 0.95, alpha: 1.0), forState: .Normal)
        nextButton.backgroundColor = UIColor(white: 0, alpha: 0.7)
        prevButton.setTitleColor(UIColor(white: 0.95, alpha: 1.0), forState: .Normal)
        prevButton.backgroundColor = UIColor(white: 0, alpha: 0.7)
        // viewMenuButton.addTarget(self, action: "applyTransition", forControlEvents: UIControlEvents.TouchUpInside)
        scroller.addSubview(nextButton)
        scroller.addSubview(prevButton)
        
        myTable = UITableView(frame: CGRect(x: 0, y: imageHeight, width: width, height: tableHeight))
        myTable.rowHeight = cellHeight
        myTable.userInteractionEnabled = false
        myTable.registerClass(KVCell.self, forCellReuseIdentifier: "main_cell")
        myTable.registerClass(NutritionCell.self, forCellReuseIdentifier: "nutrition_cell")
        myTable.delegate = self
        myTable.dataSource = self
        myTable.allowsSelection = false
        scroller.addSubview(myTable)
        // End Programatic Methods
        if index > 0{
            // navigationItem.backBarButtonItem?.action = "toFirst"
        }
    }
    func toFirst(){
        navigationController?.popToViewController(ViewController(), animated: true)
    }
    func nextDish() {
        let dest = MDishViewController()
        let next = index+1
        guard next < 3 else {return}
        dest.index = next
        dest.view.backgroundColor = UIColor(white: 0.9, alpha: 1.0)
        navigationController?.pushViewController(dest, animated: true)
    }
    
    func prevDish() {
        let next = index - 1
        guard next >= 0  else {return}
        navigationController?.popViewControllerAnimated(true)
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
        return dishKeys.count // +1 for calories
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        /*if indexPath.row == 0 {
            return cellHeight*2
        }*/
        return cellHeight
    }
    
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let idx = indexPath.row
        if false {}
        /*
        if idx == 0 {
            let cell = myTable.dequeueReusableCellWithIdentifier("nutrition_cell", forIndexPath: indexPath) as! NutritionCell
            
            cell.populate(dish.nutrition)
            return cell
        }*/
        else {
            let cell = myTable.dequeueReusableCellWithIdentifier("main_cell", forIndexPath: indexPath) as! KVCell
            
            let key = dishKeys[idx]
            cell.keyLabel.text = key.capitalizedString
            if let value = dish.dict[key] {
                cell.valueLabel.text = "\(value)".capitalizedString
            }
            else if let value = dish.nutrition.dict[key] {
                cell.valueLabel.text = "\(value)"
            }
            cell.setBounds()
            return cell
        }
    }
    
    func tableView(tableView: UITableView, willSelectRowAtIndexPath indexPath: NSIndexPath) -> NSIndexPath? {
        print("User will tap \(indexPath.row)")
        // performSegueWithIdentifier("TableToDetail", sender: self)
        return indexPath
    }
    
    
    
}

