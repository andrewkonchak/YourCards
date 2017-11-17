//
//  CardFullViewController.swift
//  YourCards
//
//  Created by Andrew on 11/13/17.
//  Copyright © 2017 Andrew Konchak. All rights reserved.
//

import UIKit
import RSBarcodes_Swift
import AVFoundation

class CardFullViewController: UIViewController,UIScrollViewDelegate {
    
    @IBOutlet weak var cardFrontFullView: UIImageView!
    @IBOutlet weak var cardBarcodeFullView: UIImageView!
    @IBOutlet weak var cardBackImageFullView: UIImageView!
    @IBOutlet weak var cardNumberFullLabel: UILabel!
    @IBOutlet weak var cardDescriptionFullView: UILabel!
    
    var cardFromCell: Card?
    var userCardManager = CardsManager()
    var userBarcode = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        roundedCardsWithColor()
        userPhotoView()
        cardBackImageFullView.image = rotateImageToView(cardBackImageFullView.image)
    }
    
    @IBAction func cardEdit(_ sender: UIButton) {
        performSegue(withIdentifier: "editCard", sender: self)
    }
    
    func roundedCardsWithColor(){
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
    }
    
    func userPhotoView(){
        cardFrontFullView.image = CardsManager.convertBase64ToImage(base64String: cardFromCell?.cardFrontImage ?? "")
        cardBackImageFullView.image = CardsManager.convertBase64ToImage(base64String: cardFromCell?.cardBackImage ?? "")
        cardDescriptionFullView.text = cardFromCell?.cardDescription
        cardNumberFullLabel.text = cardFromCell?.cardNumber
        cardBarcodeFullView?.image = RSUnifiedCodeGenerator.shared.generateCode(cardNumberFullLabel.text ?? "", machineReadableCodeObjectType: AVMetadataObject.ObjectType.ean13.rawValue)
}
    
    func rotateImageToView(_ image: UIImage?) -> UIImage? {
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
        
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "editCard"{
            let editUserCard = segue.destination as! AddNewCardViewController
            editUserCard.editCard = cardFromCell
        } 
    }

}
