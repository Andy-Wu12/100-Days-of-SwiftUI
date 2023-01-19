//
//  DynamicFetchFilter.swift
//  CoreDataProject
//
//  Created by Andy Wu on 1/18/23.
//

import SwiftUI

struct DynamicFetchFilter: View {
    @Environment(\.managedObjectContext) var moc
    @State private var firstNameFilter = "A"
    @State private var predicate: Predicate = .beginsWith
    
    var body: some View {
        VStack {
            FilteredList(filterKey: "firstName", filterValue: firstNameFilter, predicate: predicate, sortDescriptors: [
                SortDescriptor(\Singer.lastName),
                SortDescriptor(\Singer.firstName)
            ]) { (singer: Singer) in
                Text("\(singer.wrappedFirstName) \(singer.wrappedLastName)")
            }
            Button("Add Examples") {
                let taylor = Singer(context: moc)
                taylor.firstName = "Taylor"
                taylor.lastName = "Swift"
                
                let ariana = Singer(context: moc)
                ariana.firstName = "Ariana"
                ariana.lastName = "Grande"
                
                let adele = Singer(context: moc)
                adele.firstName = "Adele"
                adele.lastName = "Adkins"
                
                try? moc.save()
            }
            
            Button("Show starts with A") {
                firstNameFilter = "A"
                predicate = .beginsWith
            }
            
            Button("Show starts with T") {
                firstNameFilter = "T"
                predicate = .beginsWith
            }
            
            Button("Show less than Z") {
                firstNameFilter = "Z"
                predicate = .lessThan
            }
            
            Button("Show Ariana") {
                firstNameFilter = "Ariana"
                predicate = .equalTo
            }
        }
    }
}

struct DynamicFetchFilter_Previews: PreviewProvider {
    static var previews: some View {
        DynamicFetchFilter()
    }
}
