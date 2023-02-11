//
//  MapLocation.swift
//  BucketList-14
//
//  Created by Andy Wu on 2/11/23.
//

import Foundation

struct MapLocation: Identifiable, Codable, Equatable {
    let id: UUID
    var name: String
    var description: String
    var latitude: Double
    var longitude: Double
    
}
