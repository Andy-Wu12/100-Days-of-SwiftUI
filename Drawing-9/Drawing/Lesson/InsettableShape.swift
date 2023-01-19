//
//  InsettableShape.swift
//  Drawing
//
//  Created by Andy Wu on 12/25/22.
//

import SwiftUI

struct InsettableShapeView: View {
    var body: some View {
        /*
         If you create a shape without a specific size, it automatically expands to occupy all available space.
         Notice how the stroke below causes the circle's left and right border edges cut off.
         This is due to how SwiftUI draws borders around shapes.
         Think tracing outline with thick pen, half of the pen will be inside, other half outside.
        */
        VStack {
//            Circle()
//             .stroke(.blue, lineWidth: 100)
            /// This modifier fixes the issues from above by making SwiftUI stroke INSIDE the border instead of centering on the line.
//                .strokeBorder(.blue, lineWidth: 100)
            InsetArc(startAngle: .degrees(0), endAngle: .degrees(110), clockwise: true)
                .stroke(.blue, lineWidth: 40)
                .frame(width: 100, height: 100)
        }
    }
}

/*
 So why does strokeBorder() exist on Circle but not Arc even though both are shapes?
 Circle also conforms to a second protocol named InsettableShape.
 An InsettableShape is a shape that can be inset - reduced inwards - by a certain amount
    to product another shape.
*/
 
/*
 If we want to make Arc work, we need to conform to Insettable Shape, which requires one additional method inset(by:)
 This will be given the inset amount (half the line width of our stroke) and should return a new kind of insettable shape
 However, we have no way of knowing the arc's actual size since path(in:) hasn't been called yet.
 The solution to this is to add a new insetAmount property defaulting to 0, and add to that whenever inset(by:) is called.
*/

struct InsetArc: InsettableShape {
    var startAngle: Angle
    var endAngle: Angle
    var clockwise: Bool
    
    var insetAmount = 0.0
    
    func inset(by amount: CGFloat) -> some InsettableShape {
        var arc = self
        arc.insetAmount += amount
        return arc
    }
    
    func path(in rect: CGRect) -> Path {
        let rotationAdjustment = Angle.degrees(90)
        let modifiedStart = startAngle - rotationAdjustment
        let modifiedEnd = endAngle
        
        var path = Path()
        path.addArc(center: CGPoint(x: rect.midX, y: rect.midY), radius: rect.width / 2 - insetAmount, startAngle: modifiedStart, endAngle: modifiedEnd, clockwise: !clockwise)
        
        return path
    }
}

struct InsettableShape_Previews: PreviewProvider {
    static var previews: some View {
        InsettableShapeView()
    }
}
