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
    @IBOutlet weak var animationImage: UIImageView!
    @IBOutlet weak var animateSwitch: UISwitch!
    @IBOutlet weak var touchIDSwitch: UISwitch!
    
    let defaults = UserDefaults.standard

    override func viewDidLoad() {
        super.viewDidLoad()
        touchIdImage.layer.cornerRadius = 28
        animationImage.layer.cornerRadius = 28
        
            touchIDSwitch.setOn(defaults.bool(forKey: "touchID"), animated: true)
            animateSwitch.setOn(defaults.bool(forKey: "tableViewAnimate"), animated: true)
        
    }
    
    
    @IBAction func touchIDChanged(_ sender: UISwitch) {
        defaults.set(sender.isOn, forKey: "touchID")
    }
    
    @IBAction func animateSwitchChanged(_ sender: UISwitch) {
        defaults.set(sender.isOn, forKey: "tableViewAnimate")
    }
    
}
