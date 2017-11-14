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
    @IBOutlet weak var cardDescriptionFullView: UITextView!
    
    
    var cardFromCell: Card?
    var userCardManager = CardsManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.cardFrontFullView?.isUserInteractionEnabled = true
        
        cardBackImageFullView.layer.cornerRadius = 15
        cardBackImageFullView.layer.borderColor = #colorLiteral(red: 0.2275260389, green: 0.6791594625, blue: 0.5494497418, alpha: 1)
        cardBackImageFullView.layer.borderWidth = 2
        
        cardFrontFullView.layer.cornerRadius = 15
        cardFrontFullView.layer.borderColor = #colorLiteral(red: 0.2275260389, green: 0.6791594625, blue: 0.5494497418, alpha: 1)
        cardFrontFullView.layer.borderWidth = 2
        
        cardBarcodeFullView.layer.cornerRadius = 15
        cardBarcodeFullView.layer.borderColor = #colorLiteral(red: 0.2275260389, green: 0.6791594625, blue: 0.5494497418, alpha: 1)
        cardBarcodeFullView.layer.borderWidth = 2
        
        cardNumberFullLabel.layer.cornerRadius = 15
        cardNumberFullLabel.layer.borderColor = #colorLiteral(red: 0.2275260389, green: 0.6791594625, blue: 0.5494497418, alpha: 1)
        cardNumberFullLabel.layer.borderWidth = 2
        
        cardDescriptionFullView.layer.cornerRadius = 15
        cardDescriptionFullView.layer.borderColor = #colorLiteral(red: 0.2275260389, green: 0.6791594625, blue: 0.5494497418, alpha: 1)
        cardDescriptionFullView.layer.borderWidth = 2
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func loadPhotoToFullView(){
        cardBackImageFullView.image = userCardManager.convertBase64ToImage(base64String: (cardFromCell?.cardBackImage)!)
    }
    
    func rotateImageToView(_ image: UIImage?)->UIImage? {
        if let userImage = image {
            let rotateSize = CGSize(width: userImage.size.height, height: userImage.size.width)
            UIGraphicsBeginImageContextWithOptions(rotateSize, true, 2.0)
            if let context = UIGraphicsGetCurrentContext() {
                context.rotate(by: 90.0 * CGFloat(Double.pi) / 180.0)
                context.translateBy(x: 0, y: -userImage.size.height)
                userImage.draw(in: CGRect.init(x: 0, y: 0, width: userImage.size.width, height: userImage.size.height))
                let rotateImage = UIGraphicsGetImageFromCurrentImageContext()
                UIGraphicsEndImageContext()
                return rotateImage!
            }
        }
        return nil
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
