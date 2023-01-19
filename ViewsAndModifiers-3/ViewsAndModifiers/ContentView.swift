//
//  ContentView.swift
//  ViewsAndModifiers
//
//  Created by Andy Wu on 12/7/22.
//

import SwiftUI

struct ContentView: View {
    @State private var useWhiteText = false
    
    var body: some View {
        // Conditional modifiers
        Button("Toggle Text Color") {
            // flip the Boolean between true and false
            useWhiteText.toggle()
        }
        .foregroundColor(useWhiteText ? .white : .blue)
        .background(.secondary)
        
        // Why modifier order MATTERS
        VStack {
            Button("Hello, world!") {}
                .background(.red)
                // Notice how this DOES NOT create a 200 x 200px red background. Instead, it is only behind the text.
                .frame(width: 200, height: 200)
            
            Button("Hello, world!!") {}
                // But modifying the frame size BEFORE applying the background color gives exactly what we want
                .frame(width: 200, height: 200)
                .background(.red)
        }
        // This is due to how Views work internally. These modifiers do not simply modify properties in the view,
        // but instead create a new struct with that modifier applied. If we type print(type(of: self.body))
        // on button click, we will see something along the lines of ModifiedContent<ModifiedContent<Button<Text> ...
        // More broadly,
        // Every time we modify a view SwiftUI applies that modifer by using generics we get
            // ModifiedContent<ViewToTransform, ChangeToMake>
        // When we have multiple modifiers, they just stack up
            // ModifiedContent<ModifiedContent<...`
            
        // Important side effect of modifiers is that we can apply the same effect multiple times, which simply adds to whatever effects were applied directly before each time.
        VStack {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundColor(.accentColor)
            .padding()
            .background(.regularMaterial)
            .padding()
            .background(.red)
            .padding()
            .background(.blue)
            .padding()
            .background(.thickMaterial)
            .padding()
            .background(.green)
            .padding()
            .background(.yellow)
            
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    
        // Without wrapping Views in VStack here, they still render properly in build due to special @ViewBuilder attribute to body property.
        // @ViewBuilder silently wraps multiple views in a TupleView containers so these "multiple views" get combined into one TupleView

        // TupleViews are also the reason why SwiftUI limits number of child views to 10
        // TupleView<(C0)> ... TupleView<(C0, C1, C2, C3, C4, ... C9)> were all that Apple decided to write
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
