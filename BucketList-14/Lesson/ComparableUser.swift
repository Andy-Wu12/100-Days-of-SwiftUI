//
//  ComparableUser.swift
//  BucketList-14
//
//  Created by Andy Wu on 2/9/23.
//

import Foundation

struct User: Identifiable, Comparable {
    let id = UUID()
    let firstName: String
    let lastName: String
    
    static func <(lhs: User, rhs: User) -> Bool {
        lhs.lastName < rhs.lastName
    }
    
    // Conforming to Comparable automatically gives access to > operator too.
    // If we don't override it, Swift creates it for us by using < and flipping the Boolean beteween T and F
}
