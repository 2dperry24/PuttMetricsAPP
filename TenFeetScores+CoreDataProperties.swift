//
//  TenFeetScores+CoreDataProperties.swift
//  
//
//  Created by User on 12/13/17.
//
//

import Foundation
import CoreData


extension TenFeetScores {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<TenFeetScores> {
        return NSFetchRequest<TenFeetScores>(entityName: "TenFeetScores")
    }

    @NSManaged public var percentage: Double
    @NSManaged public var puttsTaken: Int16

}
