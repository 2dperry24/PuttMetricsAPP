//
//  FortyFeetScores+CoreDataProperties.swift
//  
//
//  Created by User on 12/13/17.
//
//

import Foundation
import CoreData


extension FortyFeetScores {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<FortyFeetScores> {
        return NSFetchRequest<FortyFeetScores>(entityName: "FortyFeetScores")
    }

    @NSManaged public var percentage: Double
    @NSManaged public var puttsTaken: Int16
    @NSManaged public var windDirection: Int16
}
