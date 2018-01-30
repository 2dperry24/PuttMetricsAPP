//
//  Bag+CoreDataProperties.swift
//  
//
//  Created by User on 1/27/18.
//
//

import Foundation
import CoreData


extension Bag {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Bag> {
        return NSFetchRequest<Bag>(entityName: "Bag")
    }

    @NSManaged public var image: NSObject?
    @NSManaged public var name: String?
    @NSManaged public var information: String?
    @NSManaged public var type: String?
}
