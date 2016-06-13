//
//  FirstViewController.swift
//  test_pageviewcontroller
//
//  Created by John on 16/6/12.
//  Copyright © 2016年 John. All rights reserved.
//

import UIKit

class FirstViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
    @IBAction func btnClick(sender: AnyObject) {
        let viewController = self.storyboard?.instantiateViewControllerWithIdentifier("ViewController") as? ViewController
        self.navigationController?.pushViewController(viewController!, animated: true)
    }
    

}

