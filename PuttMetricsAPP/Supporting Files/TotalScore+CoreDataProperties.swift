//
//  TotalScore+CoreDataProperties.swift
//  
//
//  Created by User on 12/13/17.
//
//

import Foundation
import CoreData


extension TotalScore {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<TotalScore> {
        return NSFetchRequest<TotalScore>(entityName: "TotalScore")
    }

    @NSManaged public var date: NSDate?
    @NSManaged public var total: Double

}
