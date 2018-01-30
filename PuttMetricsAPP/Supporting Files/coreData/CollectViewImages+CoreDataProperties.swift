//
//  CollectViewImages+CoreDataProperties.swift
//  
//
//  Created by User on 1/28/18.
//
//

import Foundation
import CoreData


extension CollectViewImages {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<CollectViewImages> {
        return NSFetchRequest<CollectViewImages>(entityName: "CollectViewImages")
    }

    @NSManaged public var imageData: NSData?
    @NSManaged public var id: Double

}
