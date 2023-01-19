//
//  SpecialEffects.swift
//  Drawing
//
//  Created by Andy Wu on 12/27/22.
//

import SwiftUI

/*
    Blend modes allow us to control the way one view is rendered on top of another.
    The default mode is .normal, which just draws the pixels from the new view onto whatever is behind,
        but there are lots of options for controlling color and opacity.
*/
struct SpecialEffects: View {
    var body: some View {
//        StandardBlend()
//        ShortcutBlend()
//        ScreenExample()
        SaturationExample()
    }
}

struct StandardBlend: View {
    var body: some View {
        ZStack {
            Image("Bird")
            
            Rectangle()
                .fill(.red)
                /*
                 Multiply is named as such because it multiplies each source pixel color w/ destination pixel color
                 In our case, each pixel of image and each pixel of rectangle on top.
                 Each pixel has RGBA values from 0 (none of color) - 1 (all of that color).
                 Therefore, highest resulting color is 1x1, lowest 0x0
                 
                 */
                .blendMode(.multiply)
        }
        .frame(width: 400, height: 500)
        .clipped()
    }
}

struct ShortcutBlend: View {
    /*
     Multiply is so common that there's a shortcut modifier
     to avoid using a ZStack like above
    */
    var body: some View {
        Image("Bird")
            .colorMultiply(.red)
    }
}

struct ScreenExample: View {
    @State private var amount = 0.0
    
    var body: some View {
        /*
         Blended color in center isn't fully white due to SwiftUI's
         adaptive colors designed to look good in both light and dark mode.
         
         If you want to see full effect of blending red, green, blue,
         use .fill for the colors below like this
         .fill(Color(red: 1, green: 0, blue: 0)) ...
         */
        VStack {
            ZStack {
                Circle()
                    .fill(.red)
                    .frame(width: 200 * amount)
                    .offset(x: -50, y: -80)
                    .blendMode(.screen)
                
                Circle()
                    .fill(.green)
                    .frame(width: 200 * amount)
                    .offset(x: 50, y: -80)
                    .blendMode(.screen)
                
                Circle()
                    .fill(.blue)
                    .frame(width: 200 * amount)
                    .blendMode(.screen)
            }
            .frame(width: 300, height: 300)
            
            Slider(value: $amount)
                .padding()
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(.black)
        .ignoresSafeArea()
    }
}

// Saturtaion adjusts how much color is used inside a view.
// 0 = no color, just grayscale, 1 = full color
struct SaturationExample: View {
    @State private var amount = 0.0
    
    var body: some View {
        VStack {
            Image("Bird")
                .resizable()
                .scaledToFit()
                .frame(width: 200, height: 200)
                // Slider value of zero means image is blurred and colorless
                // As slider moved to the right, it gains color and becomes sharp
                .saturation(amount)
                .blur(radius: (1 - amount) * 20)
            
            Slider(value: $amount)
                .padding()
        }
    }
}

struct SpecialEffects_Previews: PreviewProvider {
    static var previews: some View {
        SpecialEffects()
    }
}
