//
//  ContentView.swift
//  Drawing
//
//  Created by Andy Wu on 12/23/22.
//

import SwiftUI

struct ContentView: View {
    // Challenge 2
    @State private var arrowThickness = 10.0
    
    // Challenge 3
    @State private var colorCycle = 0.0
    @State private var numSteps = 100.0
    
    var body: some View {
        VStack {
            // Challenge 1 + 2
            Arrow(insetAmount: arrowThickness)
                .strokeBorder(.blue, lineWidth: arrowThickness)
                .onTapGesture {
                    withAnimation {
                        arrowThickness = Double.random(in: 1.0...125.0)
                    }
                }
            
//             Challenge 3
            VStack {
                withAnimation {
                    ColorCyclingRect(amount: colorCycle, steps: Int(numSteps))
                }
                Text("Amount ")
                Slider(value: $colorCycle)
                Text("Inset size")
                Slider(value: $numSteps, in: 1...100)
            }
            .padding([.horizontal, .bottom])
        }
    }
}

struct Arrow: InsettableShape {
    var insetAmount = 0.0
    
    func inset(by amount: CGFloat) -> some InsettableShape {
        var arrow = self
        arrow.insetAmount += amount
        return arrow
    }
    
    func path(in rect: CGRect) -> Path {
        var path = Path()
        
        // Left Head
        path.move(to: CGPoint(x: rect.midX, y: 0))
        path.addLine(to: CGPoint(x: rect.minX, y: rect.midY / 2))
        path.addLine(to: CGPoint(x: rect.midX * 0.5, y: rect.midY / 2))
        
        // Shaft
        path.addLine(to: CGPoint(x: rect.midX * 0.5, y: rect.maxY / 2))
        path.addLine(to: CGPoint(x: rect.midX * 1.5, y: rect.maxY / 2))
        path.addLine(to: CGPoint(x: rect.midX * 1.5, y: rect.midY / 2))
        path.addLine(to: CGPoint(x: rect.maxX, y: rect.midY / 2))
        
        path.closeSubpath()
        
        
        return path
    }
}

struct ColorCyclingRect: View {
    var amount = 0.0
    var steps = 100
    
    var animatableData: AnimatablePair<Double, Double> {
        get { AnimatablePair(Double(amount), Double(steps)) }
        set {
            amount = newValue.first
            steps = Int(newValue.second)
        }
    }
    
    var body: some View {
        ZStack {
            ForEach(0..<steps) { value in
                Rectangle()
                    .inset(by: Double(value))
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

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
