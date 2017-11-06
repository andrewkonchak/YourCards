//
//  Card+CoreDataClass.swift
//  YourCards
//
//  Created by Andrew on 11/6/17.
//  Copyright © 2017 Andrew Konchak. All rights reserved.
//
//

import Foundation
import CoreData

@objc(Card)
public class Card: NSManagedObject {
    
    @nonobjc public class func fetchRequest() -> NSFetchRequest<Card> {
        return NSFetchRequest<Card>(entityName: "Card")
    }
    
    @NSManaged public var cardName: String?
    @NSManaged public var cardNumber: String?
    @NSManaged public var cardDate: NSDate?
    @NSManaged public var cardDescription: String?
    @NSManaged public var cardFrontImage: String?
    @NSManaged public var cardBackImage: String?
    @NSManaged public var cardBarcode: String?
}
