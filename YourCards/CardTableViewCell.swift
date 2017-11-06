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
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func configureCell(card: Card){
        self.cardNameLabelCell.text = card.cardName
//        self.cardFrontImageViewCell.image = UIImage(data: (card.cardFrontImage as? Data)!)
    }

}
