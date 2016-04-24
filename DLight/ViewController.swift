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
        // MARK - For StoryBoarded View
        // self.performSegueWithIdentifier("MainToProfile", sender: nil)
        // MARK - Programmatic View
        let dest = MProfileViewController()
        dest.view.backgroundColor = UIColor(white: 0.9, alpha: 1.0)
        navigationController?.pushViewController(dest, animated: true)
    }
    
    @IBAction func searchButtonPressed(sender: UIButton) {
        self.performSegueWithIdentifier("MainToResults", sender: nil)
    }
    @IBAction func dishButtonPressed(sender: AnyObject) {
        // MARK - For StoryBoarded View
        // self.performSegueWithIdentifier("MainToDishes", sender: nil)
        // MARK - Programmatic View
        let dest = MDishViewController()
        dest.view.backgroundColor = UIColor(white: 0.9, alpha: 1.0)
        navigationController?.pushViewController(dest, animated: true)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

