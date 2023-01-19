//
//  ImagePaint.swift
//  Drawing
//
//  Created by Andy Wu on 12/27/22.
//

import SwiftUI

/*
    SwiftUI gives us a dedicated type that wraps images in a way that gives
    us complete control over how they should be rendered.
    This allows us to use them as border and fills without problems.
*/
struct ImagePaintLesson: View {
    var body: some View {
        ScrollView(.vertical) {
            VStack {
                Text("Hello")
                    .frame(width: 300, height: 300)
                    .background(.red)
                Text("Hello")
                    .frame(width: 300, height: 300)
                    /// Doesn't work! So how would be workaround it?
                    //  .border(Image("Bird"), width: 30)
                    
                /*
                 Use ImagePaint, which has 3 parameters, 1 which is required
                    1. image: Image - Required
                    2. sourceRect:  CGRect representing rectangle within image to use as source. Has (x, y, width, height) values betwen 0 and 1 representing relative sizes
                    3. scale: double
                */
                //  .border(ImagePaint(image: Image("Bird"), scale: 0.2), width: 30)
                /// The modifier below shows the entire width of image, but only middle half
                    .border(ImagePaint(image: Image("Bird"), sourceRect: CGRect(x: 0, y: 0.25, width: 1, height: 0.5), scale: 0.1), width: 30)
                
                /// Image paint can also be used for view backgrounds and also shape strokes.
                /// For exmaple, we can create capsule with our example image tiled as its stroke
                /// ImagePaint will automatically keep tiling its image until it has filled its area.
                /// It can work with backgrounds, strokes, borders, and fills of any size.
                Capsule()
                    .strokeBorder(ImagePaint(image: Image("Bird"), scale: 0.1), lineWidth: 20)
                    .frame(width: 300, height: 200)
            }
        }
    }
}

struct ImagePaint_Previews: PreviewProvider {
    static var previews: some View {
        ImagePaintLesson()
    }
}
