//
//  Score+CoreDataProperties.swift
//  
//
//  Created by User on 12/12/17.
//
//

import Foundation
import CoreData


extension Score {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Score> {
        return NSFetchRequest<Score>(entityName: "Score")
    }

    @NSManaged public var date: NSDate?
    @NSManaged public var levelScore: Double
    @NSManaged public var totalPutts: Int16

}
