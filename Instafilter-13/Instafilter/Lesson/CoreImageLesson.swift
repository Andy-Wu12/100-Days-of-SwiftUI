//
//  CoreImageLesson.swift
//  Instafilter
//
//  Created by Andy Wu on 2/1/23.
//

import SwiftUI
import CoreImage
import CoreImage.CIFilterBuiltins

/*
 Core Data is Apple's built-in framework for manipulating images.
 This includes sharpening, blurs, vignettes, pixellation, etc. like in the built-in Photo Booth app
*/

/*
 Apart from SwiftUI's Image, there are three other image types
 1. UIImage, which comes from UIKit, is closest to Image.
    Extremely powerful image type capable of working with variety of image types (PNG, SVG, etc).
 
 2. CGImage, which comes from Core Graphics. This is a simpler image type that is just a 2D array of pixels.
 
 3. CIImage, which comes from Core Image. This stores all info required to produce an image
    but doesn't actually turn that into pixels unless asked to.
    Apple calls these "image recipes" rather than actual images.
 */

/*
 Interopability between image types
 
 1. UIImage <-> CGIImage
 2. CGImage || UIImage -> CIImage, CIImage -> CGImage
 3. UIImage || CGImage -> Image
 */

struct CoreImageLesson: View {
    @State private var image: Image?
    
    var body: some View {
        VStack {
            image?
                .resizable()
                .scaledToFit()
        }
        .onAppear(perform: loadImage)
    }
    
    func loadImage() {
        guard let inputImage = UIImage(named: "Bird") else { return }
        let beginImage = CIImage(image: inputImage)
        
        // Create Core Image context and Core Image filter
        let context = CIContext()
        let currentFilter = CIFilter.sepiaTone()
        
        currentFilter.inputImage = beginImage
        currentFilter.intensity = 1
        
        // get a CIImage from our filter or exit if that fails
        guard let outputImage = currentFilter.outputImage else { return }
        // attempt to get a CGImage from our CIImage
        if let cgimg = context.createCGImage(outputImage, from: outputImage.extent) {
            // convert that to a UIImage
            let uiImage = UIImage(cgImage:  cgimg)
            
            // and convert that to a SwiftUI image
            image = Image(uiImage: uiImage)
        }
    }
}

struct CoreImageLesson_Previews: PreviewProvider {
    static var previews: some View {
        CoreImageLesson()
    }
}
