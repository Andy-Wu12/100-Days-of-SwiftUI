//
//  CoreDataProjectApp.swift
//  CoreDataProject
//
//  Created by Andy Wu on 1/17/23.
//

import SwiftUI

@main
struct CoreDataProjectApp: App {
    @State private var dataController = DataController()
    var body: some Scene {
        WindowGroup {
//            ContentView()
//            FetchRequestPredicate()
            DynamicFetchFilter()
//            OneToManyRelationships()
                .environment(\.managedObjectContext, dataController.container.viewContext)
        }
    }
}

