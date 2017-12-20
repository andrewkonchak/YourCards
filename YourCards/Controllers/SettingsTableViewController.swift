//
//  SettingsTableViewController.swift
//  YourCards
//
//  Created by Andrew on 11/15/17.
//  Copyright © 2017 Andrew Konchak. All rights reserved.
//

import UIKit
import LocalAuthentication

class SettingsTableViewController: UITableViewController {
    
    @IBOutlet weak var touchIdImage: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        touchIdImage.layer.cornerRadius = 20
    }
    
    var tableViewAnimate = CardTableViewController()
    
    @IBAction func `switch`(_ sender: UISwitch) {
     
    }
    

    
}
