//
//  DataController.swift
//  Bookworm
//
//  Created by Andy Wu on 1/14/23.
//

import Foundation
import CoreData

class DataController: ObservableObject {
    // Responsible for loading data model
    let container = NSPersistentContainer(name: "Bookworm")
    
    init() {
        // Load data model and handle potential errors
        container.loadPersistentStores { description, error in
            if let error = error {
                print("Core data failed to load: \(error.localizedDescription)")
            }
        }
    }
}
