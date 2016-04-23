//
//  ViewController.swift
//  DLight
//
//  Created by Zach Zeleznick on 3/15/16.
//  Copyright © 2016 zzeleznick. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    @IBAction func nextButtonPressed(sender: UIButton) {
        self.performSegueWithIdentifier("MainToProfile", sender: nil)
    }
    
    @IBAction func searchButtonPressed(sender: UIButton) {
        self.performSegueWithIdentifier("MainToResults", sender: nil)
    }
    @IBAction func dishButtonPressed(sender: AnyObject) {
        self.performSegueWithIdentifier("MainToDishes", sender: nil)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

