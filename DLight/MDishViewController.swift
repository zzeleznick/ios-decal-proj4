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
    
    private let keys = ["entree", "dietary intake restrictions",
        "dietary restrictions", "user rating", "nutrition facts"]
    
    private let dummyData: [String: Any] = ["entree": "grilled atlantic salmon", "dietary intake restrictions": "low calorie", "dietary restrictions": "pescaterian",
        "user rating": "a- 362 reviews", "nutrition facts": "320 calories"]
    
    let dish = Dish(name: "Grilled Atlantic Salmon",
        nutrition:  NutritionWrapper(calories: 360, carbs: 10, protein: 34, sugar:8, fat:5),
        ingredients: IngredientWrapper(ingredients: ["Atlantic Salmon", "3 blend seasoning", "salt"], intakeRestrictions: ["Low Sodium", "Low Calorie"], dietaryRestrictions: ["Pescatarian"]),
        merchant: MerchantWrapper(price: "$14", photo: nil) )
    
    var dishKeys: [String]!

    override func viewDidLoad() {
        super.viewDidLoad()
        dishKeys = [String](dish.dict.keys)
        let nutritionKeys = [String](dish.nutrition.dict.keys)
        for key in nutritionKeys {
             dishKeys.append(key)
        }
        dishKeys.sortInPlace()
        
        // Programatic Methods
        view = UIView(frame: UIScreen.mainScreen().bounds)
        view.backgroundColor = UIColor(white: 0.9, alpha: 1.0)
        navigationItem.title = "Dish"
        width = UIScreen.mainScreen().bounds.size.width
        height = UIScreen.mainScreen().bounds.size.height
        
        let tableHeight:CGFloat = CGFloat(dishKeys.count) * cellHeight + 10 + nutritionHeight
        
        scroller = UIScrollView(frame: CGRect(x: 0, y: 0, width: width, height: height))
        scroller.contentSize = CGSizeMake(width, imageHeight+0.8*cellHeight+tableHeight)
        scroller.delegate = self
        view.addSubview(scroller)
        
        let image = UIImage(named: "salmon_wide")
        let imageFrame = UIImageView(image: image)
        imageFrame.frame = CGRect(x: 0, y: 0, width: width, height: imageHeight)
        scroller.addSubview(imageFrame)
        
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

