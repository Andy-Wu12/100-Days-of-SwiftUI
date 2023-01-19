//
//  ScrollView.swift
//  Moonshot
//
//  Created by Andy Wu on 12/18/22.
//

import SwiftUI

struct ScrollViewLesson: View {
    var body: some View {
        /// Horizontal scrollviews can be created with .horizontal paramater argument i.e ScrollView(.horizontal) { ... }
        /// Make sure to create a HORIZONTAL (LAZY) stack so that content is laid out as expected
        ScrollView {
            /// Without the LAZYVSTACK every single item meant to be printed
                /// regardless of whether or not we see it on screen, is rendered immediately
            /// LAZYVSTACK only creates the CustomText structs below when needed)
            /// LazyStacks ALWAYS take up as much room as is available in our layouts
                /// while regular stacks only take up as much space as needed.
                /// This is important because it stops lazy stacks from having to adjust their size if a new view is loaded
                /// that requests more space
            LazyVStack(spacing: 10) {
                ForEach(0..<100) {
                    CustomText("Item \($0)")
                        .font(.title)
                }
            }
            .frame(maxWidth: .infinity)
        }
    }
}

struct CustomText: View {
    let text: String
    
    var body: some View {
        Text(text)
    }
    
    init(_ text: String) {
        print("Creating a new CustomText with text \(text)")
        self.text = text
    }
}

struct ScrollViewLesson_Previews: PreviewProvider {
    static var previews: some View {
        ScrollViewLesson()
    }
}
