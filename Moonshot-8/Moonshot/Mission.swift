//
//  Mission.swift
//  Moonshot
//
//  Created by Andy Wu on 12/19/22.
//

import Foundation

struct Mission: Codable, Identifiable {
    // Refer to this as Mission.CrewMember
    struct CrewMember: Codable {
        let name: String
        let role: String
    }
    
    var displayName: String {
        "Apollo \(id)"
    }
    
    var imageName: String {
        "apollo\(id)"
    }
    
    var formattedLaunchDate: String {
        launchDate?.formatted(date: .abbreviated, time: .omitted) ?? "N/A"
    }
    
    let id: Int
    // Optional properties are automatically skipped over by Codable if it is missing from input JSON
    let launchDate: Date?
    let crew: [CrewMember]
    let description: String
}
