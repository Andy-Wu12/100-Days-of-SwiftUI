//
//  UsingCustomComparable.swift
//  BucketList-14
//
//  Created by Andy Wu on 2/9/23.
//

import SwiftUI

struct UsingCustomComparable: View {
    // This sorted case is trivial
//    let values = [1, 5, 3, 6, 2, 9].sorted()
    
    // But what about a custom Object?
    let users = [
        User(firstName: "Eren", lastName: "Yeager"),
        User(firstName: "This name", lastName: "should be last"),
        User(firstName: "1st", lastName: "Name")
    ]
    // This doesn't work unless we make our struct conform to Comparable
        .sorted()
    // We could alternatively pass in a closure to sorted,
    // but it breaks rules of DRY if you are repeating the same sorting rules
    // along with telling the model how it should behave inside our SwiftUI view code
    
    var body: some View {
        List(users) {
//            Text(String($0))
            Text("\($0.firstName), \($0.lastName)")
        }
    }
}

struct UsingCustomComparable_Previews: PreviewProvider {
    static var previews: some View {
        UsingCustomComparable()
    }
}
