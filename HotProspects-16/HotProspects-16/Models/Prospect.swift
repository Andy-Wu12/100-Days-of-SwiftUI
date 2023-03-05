//
//  Prospect.swift
//  HotProspects-16
//
//  Created by Andy Wu on 2/27/23.
//

import SwiftUI

class Prospect: Identifiable, Codable {
    var id = UUID()
    var name = "Anonymous"
    var emailAddress = ""
    
    fileprivate(set) var isContacted = false
}

@MainActor class Prospects: ObservableObject {
    @Published private(set) var people: [Prospect]
    
    let saveKey = "SavedData"
    
    init() {
        if let prospects: [Prospect] = try? readDocument(name: saveKey) {
            people = prospects
        } else {
            people = []
        }
    }
    
    private func save() {
        do {
            try writeDocument(name: saveKey, for: people)
        } catch {
            return
        }
    }
    
    func add(_ prospect: Prospect) {
        people.append(prospect)
        save()
    }
    
    func toggle(_ prospect: Prospect) {
        /*
         Since the people array in Prospects is @Published but the items INSIDE are not,
         SwiftUI will not detect a change even if any of the array elements have been modified.
         
         The below is necessary to inform SwiftUI that something important changed when
         we toggle a prospect's isContacted property
        */
        objectWillChange.send()
        prospect.isContacted.toggle()
        save()
    }
}
