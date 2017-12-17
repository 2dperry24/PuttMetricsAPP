//
//  TwentyFiveFeetScores+CoreDataProperties.swift
//  
//
//  Created by User on 12/13/17.
//
//

import Foundation
import CoreData


extension TwentyFiveFeetScores {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<TwentyFiveFeetScores> {
        return NSFetchRequest<TwentyFiveFeetScores>(entityName: "TwentyFiveFeetScores")
    }

    @NSManaged public var puttsTaken: Int16
    @NSManaged public var percentage: Double

}
