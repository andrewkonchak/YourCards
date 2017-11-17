//
//  CardsManager.swift
//  YourCards
//
//  Created by Andrew on 10/31/17.
//  Copyright © 2017 Andrew Konchak. All rights reserved.
//

import UIKit
import CoreData

class CardsManager {
    
    var context = (UIApplication.shared.delegate as? AppDelegate)?.persistentContainer.viewContext
    
    func saveCard(card: Card) {
        do {
            try context?.save()
        }
        catch{
            print(error)
        }
    }
    
    func deleteCard(card: Card){
        context?.delete(card)
        try? context?.save()
    }
    
    // MARK: - Convert from base64String to UIImage
    
    static func convertBase64ToImage(base64String: String) -> UIImage {
        let decodedData = NSData(base64Encoded: base64String, options: NSData.Base64DecodingOptions(rawValue: 0))
        let decodedimage = UIImage(data: decodedData! as Data)
        
        return decodedimage!
        
    }
    
    // MARK: - Convert UIImage to base64String
    
    static func convertImageToBase64(image: UIImage) -> String {
        let imageData = UIImagePNGRepresentation(image)
        let base64String = imageData?.base64EncodedString(options: NSData.Base64EncodingOptions(rawValue: 0))
        
        return base64String ?? ""
        
    }
}




