//
//  ViewController.swift
//  YCEmptyKitSwift
//
//  Created by Loveying on 08/21/2020.
//  Copyright (c) 2020 Loveying. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        title = "YCEmptyKitSwiftDemo"
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func tableViewDemo(_ sender: UIButton) {
        navigationController?.pushViewController(TableViewDemoController(), animated: true)
    }
    
    @IBAction func collectionView(_ sender: UIButton) {
        navigationController?.pushViewController(CollectionViewDemoViewController(), animated: true)
    }
}

