//
//  NavigationLink.swift
//  Moonshot
//
//  Created by Andy Wu on 12/18/22.
//

import SwiftUI

struct NavigationLinkLesson: View {
    var body: some View {
        NavigationView {
            // NavigationLink vs sheet()
            /// NavLink should be for showing details about the selection
                /// as if you're digging deeper into the topic at hand
            /// sheet() is for showing unrelated content such as settings or a compose window
            List(0..<100) { row in
                NavigationLink {
                    Text("Detail \(row)")
                } label: {
                    Text("Row \(row)")
                }
            }
            .navigationTitle("SwiftUI")
        }
    }
}

struct NavigationLinkLesson_Previews: PreviewProvider {
    static var previews: some View {
        NavigationLinkLesson()
    }
}
