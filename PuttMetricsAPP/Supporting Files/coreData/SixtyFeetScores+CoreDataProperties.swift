//
//  SixtyFeetScores+CoreDataProperties.swift
//  
//
//  Created by User on 12/13/17.
//
//

import Foundation
import CoreData


extension SixtyFeetScores {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<SixtyFeetScores> {
        return NSFetchRequest<SixtyFeetScores>(entityName: "SixtyFeetScores")
    }

    @NSManaged public var puttsTaken: Int16
    @NSManaged public var percentage: Double

}
