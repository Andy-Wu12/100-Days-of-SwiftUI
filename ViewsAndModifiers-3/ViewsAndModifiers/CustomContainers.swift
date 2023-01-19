//
//  CustomContainers.swift
//  ViewsAndModifiers
//
//  Created by Andy Wu on 12/8/22.
//

import SwiftUI

struct CustomContainers: View {
    var body: some View {
        /// Using our custom stack
        GridStack(rows: 4, columns: 4) { row, col in
            Text("R\(row) C\(col)")
        }
        /// Any cell content is acceptable as long as it conforms to View protocol.
        GridStack(rows: 4, columns: 4) { row, col in
            HStack {
                Image(systemName: "\(row * 4 + col).circle")
                Text("R\(row) C\(col)")
            }
        }
        /// Adding @ViewBuilder will making SwiftUI automatically create an implicit horizontal stack inside our cell closure
        GridStack(rows: 4, columns: 4) { row, col in
            Image(systemName: "\(row * 4 + col).circle")
            Text("R\(row) C\(col)")
        }
    }
}

/// Defining custom Stacks (like Z/V/H Stack)
/// This custom stack will let us create any number of views inside a fixed grid.

/// This uses a more advanced feature known as GENERICS
/// The line below basically means a GridStack takes any sort of content
/// as long as the content conforms to View protocol.
struct GridStack<Content: View>: View {
    let rows: Int
    let columns: Int
    /// Defines a closure that must be able to accept two  integers
    /// and return some sort of content that we can show
    @ViewBuilder let content: (Int, Int) -> Content
    
    /// We don't need to say what's IN each cell, because we can get that
    /// by calling our content closure with appropriate row / column
    var body: some View {
        VStack {
            /// When looping over ranges, SwiftUI can use the range directly
            /// only if we know for sure the values in the range won't change over time.
            /// Since rows or columns CAN change over time, we need to add a second parameter to ForEach (id: \.self)
            /// to tell SwiftUI how it can identiy each view in the loop.
            ForEach(0..<rows, id: \.self) { row in
                HStack {
                    ForEach(0..<columns, id: \.self) { column in
                        content(row, column)
                    }
                }
            }
        }
    }
}

struct CustomContainers_Previews: PreviewProvider {
    static var previews: some View {
        CustomContainers()
    }
}
