//
//  FortyFiveFeetScores+CoreDataProperties.swift
//  
//
//  Created by User on 12/13/17.
//
//

import Foundation
import CoreData


extension FortyFiveFeetScores {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<FortyFiveFeetScores> {
        return NSFetchRequest<FortyFiveFeetScores>(entityName: "FortyFiveFeetScores")
    }

    @NSManaged public var puttsTaken: Int16
    @NSManaged public var percentage: Double

}
