//
//  AnimatablePair.swift
//  Drawing
//
//  Created by Andy Wu on 12/28/22.
//

import SwiftUI

/*
 SwiftUI uses an animatableData property to let uss animate changes to shapes,
 but what happens when we want more than one property to animate?
 
 animatableData is a property, meaning it must always be one value.
 However, we get to decide what type of value it is.
 It might be a single Double, or might be two values contained in a special wrapper called AnimatablePair
*/
struct AnimatablePairLesson: View {
    @State private var rows = 4
    @State private var columns = 4
    
    var body: some View {
        Checkerboard(rows: rows, columns: columns)
            .onTapGesture {
                withAnimation(.linear(duration: 3)) {
                    rows = 8
                    columns = 16
                }
            }
    }
}


struct Checkerboard: Shape {
    /*
     Issues with animation setup
     1. We have two properties that we want to animate, not just one.
     2. SwiftUI can't interpolate integers.
    */
    var rows: Int
    var columns: Int
    
    /*
     To solve these problems, we're going to use AnimatablePair
     1. Track a pair of Doubles that represent our row and column count, respectively.
     2. Convert them to Ints when SwiftUI provides us with interpolated values
    */
    var animatableData: AnimatablePair<Double, Double> {
        get {
            AnimatablePair(Double(rows), Double(columns))
        }
        
        set {
            rows = Int(newValue.first)
            columns = Int(newValue.second)
        }
    }
    /*
     So how do we animate more than two properties?
     Well this is what SwiftIUI's EdgeInsets animatableData property looks like:
     AnimatablePair<CGFloat, AnimatablePair<CGFloat, AnimatablePair<CGFloat, CGFloat>>>
     */
    
    func path(in rect: CGRect) -> Path {
        var path = Path()
        
        // figure out how big each row/column needs to be
        let rowSize = rect.height / Double(rows)
        let columnSize = rect.width / Double(columns)
        
        // loop over all rows and columns, making alternating squares colored
        for row in 0..<rows {
            for column in 0..<columns {
                if (row + column).isMultiple(of: 2) {
                    // this square should be colored; add a rectangle here
                    let startX = columnSize * Double(column)
                    let startY = rowSize * Double(row)
                    
                    let rect = CGRect(x: startX, y: startY, width: columnSize, height: rowSize)
                    path.addRect(rect)
                }
            }
        }
        return path
    }
}

struct AnimatablePair_Previews: PreviewProvider {
    static var previews: some View {
        AnimatablePairLesson()
    }
}
