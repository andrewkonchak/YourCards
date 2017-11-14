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
    
    var context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    func createNewCards (createCard: Card) {
        do {
            try context.save()
        }
        catch{
            print(error)
        }
    }
    //    func fetchCardsFromCoreData(completion: ([Card]?)->Void) {
    //        var results = [Card]()
    //        let request: NSFetchRequest<Card> = Card.fetchRequest()
    //            do {
    //                results = (try context.fetch(request) as [Card])
    //                
    //            } catch {
    //                print("Could not fetch Products from CoreData:\(error.localizedDescription)")
    //    
    //}
    //
    //}
    
    func deleteCard(card: Card){
        context.delete(card)
        try? context.save()
    }
    
    // MARK: - Convert from base64String to UIImage
    
//    func convertBase64ToImage(base64String: String) -> UIImage {
//        let decodedData = NSData(base64Encoded: base64String, options: NSData.Base64DecodingOptions(rawValue: 0))
//        let decodedimage = UIImage(data: decodedData! as Data)
//        
//        return decodedimage!
//        
//    }
}




