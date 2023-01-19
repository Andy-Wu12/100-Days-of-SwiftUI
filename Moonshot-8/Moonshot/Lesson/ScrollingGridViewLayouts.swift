//
//  ScrollingGridViewLayouts.swift
//  Moonshot
//
//  Created by Andy Wu on 12/19/22.
//

import SwiftUI

struct ScrollingGridViewLayouts: View {
    /// If we want a vertically scrolling grid with three columns
        /// each exactly 80 points wide...
    let layout = [
//        GridItem(.fixed(80)),
//        GridItem(.fixed(80)),
//        GridItem(.fixed(80))
        
        /// If we want  # grid columns to adapt to different screen sizes...
        /// We can ask SwiftUI to fit as many columns as possible (as long as they are at least 80 points in width).
        /// For an HGrid, these layouts would apply to rows parameter instead of columns
        GridItem(.adaptive(minimum: 80))
        
        /// More control is possible too.
//        GridItem(.adaptive(minimum: 80, maximum: 120))
    ]
    
    var body: some View {
        LazyVGrid(columns: layout) {
            ForEach(0..<100) {
                Text("Item \($0)")
            }
        }
    }
}

struct ScrollingGridViewLayouts_Previews: PreviewProvider {
    static var previews: some View {
        ScrollingGridViewLayouts()
    }
}
