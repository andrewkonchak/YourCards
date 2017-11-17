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
    }

    func configureCell(card: Card){
        self.cardNameLabelCell.text = card.cardName
        
        if let base64String = card.cardFrontImage {
             self.cardFrontImageViewCell.image = CardsManager.convertBase64ToImage(base64String: base64String)
        }
    
        if let date = card.cardDate {
            cardDateLabelCell?.text = DateFormatter.localizedString(from: date, dateStyle: DateFormatter.Style.long, timeStyle: DateFormatter.Style.none)
        }
    }
    
}
