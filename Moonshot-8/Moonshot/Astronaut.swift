//
//  Astronaut.swift
//  Moonshot
//
//  Created by Andy Wu on 12/19/22.
//

import Foundation

struct Astronaut: Codable, Identifiable {
    let id: String
    let name: String
    let description: String
}

struct CrewMember {
    let role: String
    let astronaut: Astronaut
}
