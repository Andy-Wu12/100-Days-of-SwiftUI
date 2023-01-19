//
//  Movie+CoreDataProperties.swift
//  CoreDataProject
//
//  Created by Andy Wu on 1/17/23.
//
//

import Foundation
import CoreData


extension Movie {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Movie> {
        return NSFetchRequest<Movie>(entityName: "Movie")
    }

    /*
        @NSManaged is NOT a property wrapper, it existed WAY before property wrappers in SwiftUI.
        This reveals how Core Data works internally.
        Rather than these values actually existing as properties in the class,
            they are just there to read and write from a dictionary that Core Data uses to store its info.
    */
    @NSManaged public var title: String?
    @NSManaged public var director: String?
    // Not optional, which means Core Data will provide a default for us
    @NSManaged public var year: Int16

    // Wrapping Core Data properties in a computed property makes it easier to handle ("remove" optional and nil coalescing)
    public var wrappedTitle: String {
        title ?? "Unknown Title"
    }
    
    public var wrappedDirector: String {
        director ?? "Unknown Director"
    }
    
    // Good idea to save only if changes to the managed object context has been made
    /*
        if moc.hasChanged {
            try? moc.save()
        }
    */
    
}

extension Movie : Identifiable {

}
