//
//  Bag+CoreDataProperties.swift
//  
//
//  Created by User on 12/12/17.
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

}
