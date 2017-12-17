//
//  ScoreFromTenFeet+CoreDataProperties.swift
//  
//
//  Created by User on 12/13/17.
//
//

import Foundation
import CoreData


extension ScoreFromTenFeet {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<ScoreFromTenFeet> {
        return NSFetchRequest<ScoreFromTenFeet>(entityName: "ScoreFromTenFeet")
    }

    @NSManaged public var percentage: Double
    @NSManaged public var puttsTaken: Int16

}
