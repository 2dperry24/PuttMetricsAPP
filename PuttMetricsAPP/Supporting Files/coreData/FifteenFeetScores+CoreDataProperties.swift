//
//  FifteenFeetScores+CoreDataProperties.swift
//  
//
//  Created by User on 12/13/17.
//
//

import Foundation
import CoreData


extension FifteenFeetScores {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<FifteenFeetScores> {
        return NSFetchRequest<FifteenFeetScores>(entityName: "FifteenFeetScores")
    }

    @NSManaged public var percentage: Double
    @NSManaged public var puttsTaken: Int16
    @NSManaged public var windDirection: Int16
}
