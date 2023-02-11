//
//  MapLocation.swift
//  BucketList-14
//
//  Created by Andy Wu on 2/11/23.
//

import MapKit

struct MapLocation: Identifiable, Codable, Equatable {
    let id: UUID
    var name: String
    var description: String
    var latitude: Double
    var longitude: Double
    
    var coordinate: CLLocationCoordinate2D {
        CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
    }
    
    // Examples are great to use in previews
    static let example = MapLocation(id: UUID(), name: "Buckingham Palace",
                                     description: "Where Quuen Elizabeth lived",
                                     latitude: 51.501, longitude: -0.141)
    
    // Override SwiftUI's provided == from Equatable
        // which (wastefully in our case) compares every property by default
    static func ==(lhs: MapLocation, rhs: MapLocation) -> Bool {
        lhs.id == rhs.id
    }
}
