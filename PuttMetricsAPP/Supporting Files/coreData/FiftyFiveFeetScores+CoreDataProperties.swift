//
//  FiftyFiveFeetScores+CoreDataProperties.swift
//  
//
//  Created by User on 12/13/17.
//
//

import Foundation
import CoreData


extension FiftyFiveFeetScores {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<FiftyFiveFeetScores> {
        return NSFetchRequest<FiftyFiveFeetScores>(entityName: "FiftyFiveFeetScores")
    }

    @NSManaged public var percentage: Double
    @NSManaged public var puttsTaken: Int16

}
