//
//  ThirtyFeetScores+CoreDataProperties.swift
//  
//
//  Created by User on 12/13/17.
//
//

import Foundation
import CoreData


extension ThirtyFeetScores {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<ThirtyFeetScores> {
        return NSFetchRequest<ThirtyFeetScores>(entityName: "ThirtyFeetScores")
    }

    @NSManaged public var puttsTaken: Int16
    @NSManaged public var percentage: Double

}
