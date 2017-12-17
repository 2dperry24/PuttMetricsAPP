//
//  TwentyFeetScores+CoreDataProperties.swift
//  
//
//  Created by User on 12/13/17.
//
//

import Foundation
import CoreData


extension TwentyFeetScores {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<TwentyFeetScores> {
        return NSFetchRequest<TwentyFeetScores>(entityName: "TwentyFeetScores")
    }

    @NSManaged public var puttsTaken: Int16
    @NSManaged public var percentage: Double

}
