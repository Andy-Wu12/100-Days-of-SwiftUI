//
//  DrawingGroupLesson.swift
//  Drawing
//
//  Created by Andy Wu on 12/27/22.
//

import SwiftUI

/*
    SwiftUI uses Core Animation for rendering by default, which offers great performance out of the box.
    However, it may slow code down for complex rendering.
    Anything below 60 FPS is a problem, but goal should really be around 120 FPS.
*/

struct DrawingGroupLesson: View {
    @State private var colorCycle = 0.0
    
    var body: some View {
        VStack {
            ColorCyclingCircle(amount: colorCycle)
                .frame(width: 300, height: 300)
            
            Slider(value: $colorCycle)
        }
    }
}

struct ColorCyclingCircle: View {
    var amount = 0.0
    var steps = 100
    
    /* This will be powered by Core Animation, which means it will turn our 100 circles
         into 100 individual views being drawn onto the screen.
       This is computationally expensive, but works well enough.. until we add more complexity
     */
    var body: some View {
        ZStack {
            ForEach(0..<steps) { value in
                Circle()
                    .inset(by: Double(value))
//                    .strokeBorder(color(for: value, brightness: 1), lineWidth: 2)
                    // More complexity - 100 gradients in 100 views and makes app extremely slow
                    .strokeBorder(
                        LinearGradient(
                            gradient: Gradient(colors: [
                                color(for: value, brightness: 1),
                                color(for: value, brightness: 0.5)
                                ]),
                            startPoint: .top,
                            endPoint: .bottom
                    ),
                    lineWidth: 2
                )
            }
        }
        /*
         This is the difference maker.
         It renders view off-screen before putting it back onto the scrren as a single rendered output.
         Behind the scenes this is powered by Metal, Apple's framework for working directly with GPU for fast graphics
        */
        .drawingGroup()
    }
    
    func color(for value: Int, brightness: Double) -> Color {
        // Hue = circle # / (divide by total # of circles + then add color cycle amount)
        var targetHue = Double(value) / Double(steps) + amount
        
        /*
         Hues don't automatically wrap, however. A hue of 1.0 is equal to a hue of 0.0
           but a hue of 1.2 is NOT equal to a hue of 0.2.
         We can handle this wrapping by subtracting 1 if the hue value ever goes above 1.0
        */
        if targetHue > 1 {
            targetHue -= 1
        }
        
        return Color(hue: targetHue, saturation: 1, brightness: brightness)
    }
}

struct DrawingGroupLesson_Previews: PreviewProvider {
    static var previews: some View {
        DrawingGroupLesson()
    }
}
