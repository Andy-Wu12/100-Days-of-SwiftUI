//
//  FilteredList.swift
//  CoreDataProject
//
//  Created by Andy Wu on 1/19/23.
//

import SwiftUI
import CoreData

enum Predicate: String {
    case equalTo = "=="
    case lessThan = "<"
    case greaterThan = ">"
    
    case beginsWith = "BEGINSWITH"
    case beginsWithNoCase = "BEGINSWITH[c]"
    
    case contains = "CONTAINS"
    case containsNoCase = "CONTAINS[c]"

}

struct FilteredList<T: NSManagedObject, Content: View>: View {
    @FetchRequest var fetchRequest: FetchedResults<T>
    
    // Content closure, called once per list item
    let content: (T) -> Content
    
    // This may seem wasteful, but Core Data only re-runs the db query even if view is recreated.
    init(filterKey: String, filterValue: String, predicate: Predicate, sortDescriptors: [SortDescriptor<T>], @ViewBuilder content: @escaping (T) -> Content) {
        // %K is used for keys, difference from %@ is that is does not insert quote ('') marks
        _fetchRequest = FetchRequest<T>(sortDescriptors: sortDescriptors, predicate: NSPredicate(format: "%K \(predicate.rawValue) %@", filterKey, filterValue))
        self.content = content
    }
    
    var body: some View {
        List(fetchRequest, id: \.self) { entity in
            self.content(entity)
        }
    }
}
