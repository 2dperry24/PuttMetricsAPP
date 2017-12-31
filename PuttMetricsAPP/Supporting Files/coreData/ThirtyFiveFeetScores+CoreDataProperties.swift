//
//  ThirtyFiveFeetScores+CoreDataProperties.swift
//  
//
//  Created by User on 12/13/17.
//
//

import Foundation
import CoreData


extension ThirtyFiveFeetScores {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<ThirtyFiveFeetScores> {
        return NSFetchRequest<ThirtyFiveFeetScores>(entityName: "ThirtyFiveFeetScores")
    }

    @NSManaged public var puttsTaken: Int16
    @NSManaged public var percentage: Double
    @NSManaged public var windDirection: Int16
}
