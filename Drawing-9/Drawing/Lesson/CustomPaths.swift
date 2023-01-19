//
//  CustomPaths.swift
//  Drawing
//
//  Created by Andy Wu on 12/23/22.
//

import SwiftUI

struct CustomPaths: View {
    var body: some View {
        Path { path in
            path.move(to: CGPoint(x: 200, y: 100))
            path.addLine(to: CGPoint(x: 100, y: 300))
            path.addLine(to: CGPoint(x: 300, y: 300))
            path.addLine(to: CGPoint(x: 200, y: 100))
            /// Toggle code comment below to see difference at top of triangle.
            /// This only works with the commented .stroke() below and is unnecessary with the more complex one
//            path.closeSubpath()
        }
//        .fill(.blue)
//        .stroke(.blue, lineWidth: 10)
        /// lineCap controls how every line should be drawn w/o connection after it
        /// lineJoin controls how every line should be connected to line after it
        .stroke(.blue, style: StrokeStyle(lineWidth: 10, lineCap: .round, lineJoin: .round))
    }
}

struct CustomPaths_Previews: PreviewProvider {
    static var previews: some View {
        CustomPaths()
    }
}
