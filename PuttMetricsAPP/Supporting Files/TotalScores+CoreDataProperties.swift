//
//  TotalScores+CoreDataProperties.swift
//  
//
//  Created by User on 12/13/17.
//
//

import Foundation
import CoreData


extension TotalScores {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<TotalScores> {
        return NSFetchRequest<TotalScores>(entityName: "TotalScores")
    }

    @NSManaged public var date: NSDate?
    @NSManaged public var total: Double
  
}
