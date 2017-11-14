//
//  CardTableViewCell.swift
//  YourCards
//
//  Created by Andrew on 11/6/17.
//  Copyright © 2017 Andrew Konchak. All rights reserved.
//

import UIKit

class CardTableViewCell: UITableViewCell {
    
    @IBOutlet weak var cardDateLabelCell: UILabel!
    @IBOutlet weak var cardNameLabelCell: UILabel!
    @IBOutlet weak var cardFrontImageViewCell: UIImageView!
    
    
    override func awakeFromNib() {
        
        super.awakeFromNib()
        cardFrontImageViewCell.layer.cornerRadius = 12
        cardFrontImageViewCell.layer.borderColor = #colorLiteral(red: 0.2275260389, green: 0.6791594625, blue: 0.5494497418, alpha: 1)
        cardFrontImageViewCell.layer.borderWidth = 2
        
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
     // MARK: - Convert base64String to UIImage

    func convertBase64ToImage(base64String: String) -> UIImage {
        let decodedData = NSData(base64Encoded: base64String, options: NSData.Base64DecodingOptions(rawValue: 0))
        let decodedimage = UIImage(data: decodedData! as Data)

        return decodedimage!

    }
    
    func configureCell(card: Card){
        self.cardNameLabelCell.text = card.cardName
        self.cardFrontImageViewCell.image = convertBase64ToImage(base64String: card.cardFrontImage!)
        self.cardDateLabelCell?.text = DateFormatter.localizedString(from: card.cardDate!, dateStyle: DateFormatter.Style.long, timeStyle: DateFormatter.Style.none)
    }
    
}
