//
//  BookwormApp.swift
//  Bookworm
//
//  Created by Andy Wu on 1/13/23.
//

import SwiftUI

@main
struct BookwormApp: App {
    @State private var dataController = DataController()
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                // Place dataController into SwiftUI environment so that it can be used everywhere else in the app
                .environment(\.managedObjectContext, dataController.container.viewContext)
        }
    }
}
