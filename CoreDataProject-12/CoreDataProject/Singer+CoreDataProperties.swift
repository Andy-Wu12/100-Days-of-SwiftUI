//
//  Singer+CoreDataProperties.swift
//  CoreDataProject
//
//  Created by Andy Wu on 1/18/23.
//
//

import Foundation
import CoreData


extension Singer {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Singer> {
        return NSFetchRequest<Singer>(entityName: "Singer")
    }

    @NSManaged public var firstName: String?
    @NSManaged public var lastName: String?

    var wrappedFirstName: String {
        firstName ?? "Unknown"
    }
    
    var wrappedLastName: String {
        lastName ?? "Unknown"
    }
}

extension Singer : Identifiable {

}
