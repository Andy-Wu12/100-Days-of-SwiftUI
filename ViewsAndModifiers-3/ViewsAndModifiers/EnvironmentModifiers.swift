//
//  EnvironmentModifiers.swift
//  ViewsAndModifiers
//
//  Created by Andy Wu on 12/8/22.
//

import SwiftUI

struct EnvironmentModifiers: View {
    // Environment Modifiers //
    /// These modifiers can be applied to containers, which helps to apply the same modifier to many views at the same time.
    var body: some View {
        VStack {
            Text("Gryffindor")
            Text("Hufflepuff")
            Text("Ravenclaw")
            Text("Slytherin")
        }
        .font(.title)
        
        /// If any child views override the same modifier, the child's takes precedent.
        VStack {
            Text("Gryffindor")
                /// Notice how Gryffindor's font is larger than the rest
                .font(.largeTitle)
            Text("Hufflepuff")
            Text("Ravenclaw")
            Text("Slytherin")
        }
        .font(.title)
        
        /// This modifier overriding only works for ENVIRONMENT modifiers, not regular ones
        VStack {
            Text("Gryffindor")
                /// Notice how this attempt to disable blur doesn't work.
                /// That is because blur is a regular modifier
                /// Regular modifiers ADD to duplicate modifications instead of overriding them
                .blur(radius: 0)
            Text("Hufflepuff")
            Text("Ravenclaw")
            Text("Slytherin")
        }
        .blur(radius: 5)
        
        /// There really isn't any way to know ahead of time which modifiers are which other than testing
        /// and hoping it is mentioned in the documentation.
    }
}

struct EnvironmentModifiers_Previews: PreviewProvider {
    static var previews: some View {
        EnvironmentModifiers()
    }
}
