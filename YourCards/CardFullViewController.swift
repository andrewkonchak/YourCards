//
//  CardFullViewController.swift
//  YourCards
//
//  Created by Andrew on 11/13/17.
//  Copyright © 2017 Andrew Konchak. All rights reserved.
//

import UIKit

class CardFullViewController: UIViewController {

    @IBOutlet weak var cardFrontFullView: UIImageView!
    @IBOutlet weak var cardBarcodeFullView: UIImageView!
    @IBOutlet weak var cardBackImageFullView: UIImageView!
    @IBOutlet weak var cardNumberFullLabel: UILabel!
    @IBAction func EditCardButton(_ sender: UIButton) {
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        cardBackImageFullView.layer.cornerRadius = 12
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
