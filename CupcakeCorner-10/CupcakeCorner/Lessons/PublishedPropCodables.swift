//
//  PublishedPropCodables.swift
//  CupcakeCorner
//
//  Created by Andy Wu on 1/7/23.
//

import SwiftUI

/*
 Using @Published here will require manual effort to conform to Codable
 since it wraps our property in a Published struct.
 Published structs can store any kind of value and use generics to do so.
 In this case, Published<String>
 
 Swift automatically handles Codables in the built-in collection types, but
 SwiftUI does not provide the same conforming functionaltiy for the Published struct.
 We need to manage this conformity by following a few steps
*/
class User: ObservableObject, Codable {
    // 1. Create an enum that conforms to CodingKey
    enum CodingKeys: CodingKey {
        case name
    }
    
    /*
        2. Custom init that takes in some sort of container and use that to read values for our properties.
        Due to the required keyword,
        anyone that subclasses User must override this initializer with a custom implementation.
     
        We can prevent subclassing by marking the class as "final". Then "required" is no longer needed.
     
    */
    
    required init(from decoder: Decoder) throws {
        // Ask decoder instance for a container matching all coding keys we set in our CodingKey struct
        let container = try decoder.container(keyedBy: CodingKeys.self)
        // Read our values directly from that container by referencing our enum cases
        name = try container.decode(String.self, forKey: .name)
    }
    
    /*
        3. Conform to Codable by describing how to encode this type
        This is basically just the reverse of our initializer here
    */
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(name, forKey: .name)
    }
    
    @Published var name = "Andy Wu"
}

struct PublishedPropCodables: View {
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
    }
}

struct PublishedPropCodables_Previews: PreviewProvider {
    static var previews: some View {
        PublishedPropCodables()
    }
}
