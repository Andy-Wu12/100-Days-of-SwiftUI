//
//  HierarchicalCodableData.swift
//  Moonshot
//
//  Created by Andy Wu on 12/18/22.
//

import SwiftUI

// Codable protocol makes it trivial to decode flat data (i.e) type instance, array, dict.
// For data with a more complex structure, we need to create separate types for each level of data we have.
// See Button below
struct HierarchicalCodableData: View {
    var body: some View {
        Button("Decode JSON") {
            let input = """
            {
                "name": "Eren Yeager",
                "address": {
                    "street": "Unknown",
                    "country": "Eldia",
                    "city": "Paradis Island",
                    "district": "Shiganshina"
                }
            }
            """
            
            let data = Data(input.utf8)
            let decoder = JSONDecoder()
            if let eldian = try? decoder.decode(Eldian.self, from: data) {
                print("\(eldian.name) is from the \(eldian.address.district) district")
            }
        }
    }
}

// Structs to help in archiving the "complex" JSON structure above
struct Address: Codable {
    let street: String
    let country: String
    let city: String
    let district: String
}

struct Eldian: Codable {
    let name: String
    let address: Address
}

struct HierarchicalCodableData_Previews: PreviewProvider {
    static var previews: some View {
        HierarchicalCodableData()
    }
}
