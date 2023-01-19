//
//  PathsVsShapes.swift
//  Drawing
//
//  Created by Andy Wu on 12/24/22.
//

import SwiftUI

/// Shapes protocols requires a single path() method describing the path to draw
struct Triangle: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()
        
        /// minX -> smallest X value in rect
        /// maxX -> largest  X value in rect
        /// midX -> mid-point between minX and maxX
        path.move(to: CGPoint(x: rect.midX, y: rect.minY))
        path.addLine(to: CGPoint(x: rect.minX, y: rect.maxY))
        path.addLine(to: CGPoint(x: rect.maxX, y: rect.maxY))
        path.addLine(to: CGPoint(x: rect.midX, y: rect.minY))
        
        return path
    }
}

struct TriangleOutlineView: View {
    var lineWidth: CGFloat
    var frameWidth: CGFloat
    var frameHeight: CGFloat
    
    var body: some View {
        Triangle()
        // .fill(.red)
        /// Shapes also support same StrokeStyle param for more advanced strokes
            .stroke(.red, style: StrokeStyle(lineWidth: lineWidth, lineCap: .round, lineJoin: .round))
            .frame(width: frameWidth, height: frameHeight)
    }
}

/// Key to understanding diff between Path and Shape is reusability
/// Paths designed to do one specific thing, while shapes have flexibility of drawing space and can accept params for customization
struct Arc: Shape {
    var startAngle: Angle
    var endAngle: Angle
    var clockwise: Bool
    
    func path(in rect: CGRect) -> Path {
        let rotationAdjustment = Angle.degrees(90)
        let modifiedStart = startAngle - rotationAdjustment
        let modifiedEnd = endAngle
        
        var path = Path()
        path.addArc(center: CGPoint(x: rect.midX, y: rect.midY), radius: rect.width / 2, startAngle: modifiedStart, endAngle: modifiedEnd, clockwise: !clockwise)
        
//        path.addArc(center: CGPoint(x: rect.midX, y: rect.midY), radius: rect.width / 2, startAngle: startAngle, endAngle: endAngle, clockwise: clockwise)
        
        return path
    }
}

struct PathsVsShapes: View {
    var body: some View {
        // TriangleOutlineView(lineWidth: 50, frameWidth: 300, frameHeight: 300)
        
        /// This doesn't work as expected with commented Arc path() for two reasons
        /// 1. SwiftUI doesn't see 0 degrees as straight upwards, but instead directly right
        /// 2. Shapes measure their coords from bottom-left corner rather than top-left
        Arc(startAngle: .degrees(0), endAngle: .degrees(110), clockwise: true)
            .stroke(.blue, lineWidth: 10)
            .frame(width: 300, height: 300)
    }
}

struct PathsVsShapes_Previews: PreviewProvider {
    static var previews: some View {
        PathsVsShapes()
    }
}
