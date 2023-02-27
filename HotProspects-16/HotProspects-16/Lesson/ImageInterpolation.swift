//
//  ImageInterpolation.swift
//  HotProspects-16
//
//  Created by Andy Wu on 2/26/23.
//

import SwiftUI

/*
 When a SwiftUI Image view stretches its content to be larger than original,
 we get IMAGE INTERPOLATION, which is where iOS blends the pixels smoothly
 so that it doesn't LOOK stretched at all.
 
 When dealing with PRECISE pixels, this feature can cause problems.
*/
struct ImageInterpolation: View {
    var body: some View {
        Image("example")
            /*
             Without explicitly removing interpolation, the blended alien image
             becomes way too stretched out and blurry since the original size is very small.
             
             For our specific example, the alien looks better highly pixellated
             instead of blurred and jagged
             */
            .interpolation(.none)
            .resizable()
            .scaledToFit()
            .frame(maxHeight: .infinity)
            .background(.black)
            .ignoresSafeArea()
    }
}

struct ImageInterpolation_Previews: PreviewProvider {
    static var previews: some View {
        ImageInterpolation()
    }
}
