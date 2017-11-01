//
//  Card+CoreDataClass.swift
//  YourCards
//
//  Created by Andrew on 11/1/17.
//  Copyright © 2017 Andrew Konchak. All rights reserved.
//
//

import Foundation
import CoreData

public class Card: NSManagedObject {
    
    @nonobjc public class func fetchRequest() -> NSFetchRequest<Card> {
        return NSFetchRequest<Card>(entityName: "Card")
    }
    
    @NSManaged public var name: String?
    @NSManaged public var frontimage: String?
    @NSManaged public var backimage: String?
    @NSManaged public var barcode: String?
    @NSManaged public var date: NSDate?
    @NSManaged public var filtercolor: String?
    @NSManaged public var descriptioncard: String?
    
}





