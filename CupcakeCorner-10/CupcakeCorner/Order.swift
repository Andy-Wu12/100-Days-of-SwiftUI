//
//  Order.swift
//  CupcakeCorner
//
//  Created by Andy Wu on 1/8/23.
//

import SwiftUI

struct OrderDetails: Codable {
    static let types = ["Vanilla", "Strawberry", "Chocolate", "Rainbow"]
    
    var type = 0
    var quantity = 3
    
    var specialRequestEnabled = false {
        didSet {
            if !specialRequestEnabled {
                extraFrosting = false
                addSprinkles = false
            }
        }
    }
    var extraFrosting = false
    var addSprinkles = false
    
    var name = ""
    var streetAddress = ""
    var city = ""
    var zip = ""
    
    var hasValidAddress: Bool {
        let trimmedZip = zip.trimmingCharacters(in: .whitespacesAndNewlines)
        
        if(name.isTrimmedEmpty() || streetAddress.isTrimmedEmpty() || city.isTrimmedEmpty()) {
           return false
        }
        
        if !trimmedZip.isNumber { return false }
        
        // Could also be nine, but we'll just work with this for now.
        if(trimmedZip.count != 5) { return false }
        
        return true
    }
    
    var cost: Double {
        // $2 per cake
        var cost = Double(quantity) * 2
        
        // complicated cakes cost more
        cost += (Double(type) / 2)
        
        // $1 per cake for extra frosting
        if extraFrosting {
            cost += Double(quantity)
        }
        
        // $0.50 per cake for sprinkles
        if addSprinkles {
            cost += Double(quantity) / 2
        }
        
        return cost
    }
}

class Order: ObservableObject {
    @Published var details = OrderDetails()
}
