//
//  PropertyWrappersToStructs.swift
//  Instafilter
//
//  Created by Andy Wu on 2/1/23.
//

import SwiftUI

struct PropertyWrappersToStructs: View {
    @State private var blurAmount = 0.0 {
        /*
         Remember property wrappers wrap our property inside another struct
         @State blurAmount: Double === State<Double> blurAmount
         
         so if @State is a struct, which isn't modifiable, how are we doing that?
         
         CMD - SHFT - O search for "State" shows us .wrappedValue { get nonmutating set },
         which tells us the struct itself isn't changed, but the value being stored
            is sent off for storage in a place where it can be modified freely.
         */
        
        /*
         The below translates to "when blurAmount changes, print out its new value".
         Knowing the above, we can see why this doesn't work.
         Since @State wraps its contents, it's ACTUALLY saying
            "when the State struct that wraps blurAmount changes, print out the new blur amount."
         Neither blurAmount or State struct wrapping it are changing since the binding is directly changing
            the internally stored variable, so didSet property observer is never being triggered
         */
        didSet {
            print("New value is \(blurAmount)")
        }
    }
    
    var body: some View {
        VStack {
            Text("Hello, world!")
                .blur(radius: blurAmount)
            
            Slider(value: $blurAmount, in: 0...20)
                /*
                    to fix the problem with didSet above,
                    we can use a modifier designed to watch and handle changes
                 */
                .onChange(of: blurAmount) {
                    print("New value is \($0)!")
                }
            Button("Random Blur") {
                blurAmount = Double.random(in: 0...20)
            }
        }
        .padding()
        
    }
}

struct PropertyWrappersToStructs_Previews: PreviewProvider {
    static var previews: some View {
        PropertyWrappersToStructs()
    }
}
