//
//  TransformingShapes.swift
//  Drawing
//
//  Created by Andy Wu on 12/27/22.
//

import SwiftUI

/* Moving beyond simple shapes and paths
 CGAffineTransform describes how a path or view should be rotated, scaled, sheared. Angles are measured in radians rather than degrees.
 3.141 (PI) radians == 180 degrees
 
 Even-odd fills allows us to control how overlapping shapes should be rendered
*/

struct Flower: Shape {
    // How much to move this petal away from the center
    var petalOffset: Double = -20
    
    // Petal width
    var petalWidth: Double = 100
    
    func path(in rect: CGRect) -> Path {
        // Path that holds all petals
        var path = Path()
        
        // Count from 0 up to pi * 2, moving up pi / 8 each time
        for number in stride(from: 0, to: Double.pi * 2, by: Double.pi / 8) {
            // rotate the petal by the current value of our loop
            let rotation = CGAffineTransform(rotationAngle: number)
            
            // move the petal to be at the center of our view
            let position = rotation.concatenating(CGAffineTransform(translationX: rect.width / 2, y: rect.height / 2))
            
            // create a path for this petal using our properties plus a fixed Y and height
            let originalPetal = Path(ellipseIn: CGRect(x: petalOffset, y: 0, width: petalWidth, height: rect.width / 2))
            
            // apply our rotation/position transformation to the petal
            let rotatedPetal = originalPetal.applying(position)
            
            // add it to our main path
            path.addPath(rotatedPetal)
        }
        
        return path
    }
}

struct TransformingShapes: View {
    @State private var petalOffset = -20.0
    @State private var petalWidth = 100.0
    
    var body: some View {
        VStack {
            Flower(petalOffset: petalOffset, petalWidth: petalWidth)
//                .stroke(.red, lineWidth: 1)
            /*
             Alternatively, we can fill the shape in a satisfactory way using the even-odd rule.
             This decides whether part of a path should be colored depending on the overlaps it contains.
             
             - If a path has no overlaps, it will be filled
             - If another path overlaps it, the overlapping part won't be filled
             - If a third path overlaps the previous two, then it WILL be filled
             - ... and so on
             */
                .fill(.red, style: FillStyle(eoFill: true))
            
            Text("Offset")
            Slider(value: $petalOffset, in: -40...40)
                .padding([.horizontal, .bottom])
            
            Text("Width")
            Slider(value: $petalWidth, in: 0...100)
                .padding(.horizontal)
        }
    }
}

struct TransformingShapes_Previews: PreviewProvider {
    static var previews: some View {
        TransformingShapes()
    }
}
