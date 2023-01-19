//
//  FetchRequestPredicate.swift
//  CoreDataProject
//
//  Created by Andy Wu on 1/17/23.
//

import SwiftUI

struct FetchRequestPredicate: View {
    @Environment(\.managedObjectContext) var moc
    /*
     %@ means insert some special data here, need extra parameter to provide it.
     The below predicate means find a Ship object whose universe
        is equal to Star Wars
     
     Other comparisons include but are not limited to <, >, IN [s1, s2], AND, BEGINSWITH BEGINSWITH[ignoreCase], CONTAINS[c], NOT (at beginning of statement instead)
     
     NSCompoundPredicates also allow for building predicates out of smaller ones
     */
    @FetchRequest(sortDescriptors: [], predicate: NSPredicate(format: "universe == %@", "Star Wars")) var ships: FetchedResults<Ship>
    
    var body: some View {
        VStack {
            List(ships, id: \.self) { ship in
                Text(ship.name ?? "Unknown name")
            }
            
            Button("Add examples") {
                let ship1 = Ship(context: moc)
                ship1.name = "Enterprise"
                ship1.universe = "Star Trek"
                
                
                let ship2 = Ship(context: moc)
                ship2.name = "Defiant"
                ship2.universe = "Star Trek"

                let ship3 = Ship(context: moc)
                ship3.name = "Millennium Falcon"
                ship3.universe = "Star Wars"

                let ship4 = Ship(context: moc)
                ship4.name = "Executor"
                ship4.universe = "Star Wars"
                
                try? moc.save()
            }
        }
    }
}

struct FetchRequestPredicate_Previews: PreviewProvider {
    static var previews: some View {
        FetchRequestPredicate()
    }
}
