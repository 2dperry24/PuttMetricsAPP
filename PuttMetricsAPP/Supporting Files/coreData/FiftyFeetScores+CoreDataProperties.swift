//
//  FiftyFeetScores+CoreDataProperties.swift
//  
//
//  Created by User on 12/13/17.
//
//

import Foundation
import CoreData


extension FiftyFeetScores {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<FiftyFeetScores> {
        return NSFetchRequest<FiftyFeetScores>(entityName: "FiftyFeetScores")
    }

    @NSManaged public var percentage: Double
    @NSManaged public var puttsTaken: Int16

}
