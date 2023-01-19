//
//  ViewsAsProps.swift
//  ViewsAndModifiers
//
//  Created by Andy Wu on 12/8/22.
//

import SwiftUI

struct ViewsAsProps: View {
    // Views as Properties
    /// This is one way to make using complex view hierarchies easier.
    
    /// Text views as  properties
    let motto1 = Text("Draco dormiens")
    let motto2 = Text("nunquam titillandus")
    
    /// Swift doesn't let us create one stored property that refers to other stored properties
    /// as this would cause problems when the object is created.
    /// i.e. creating a TextField bound to a local property will cause problems.
    /// However, you can create COMPUTED properties if you want like
    var motto3: some View {
        Text("Draco dormiens")
    }
    
    /// Great way to split up complex views into smaller chunks, but need to be careful
    /// Unlike body property, Swift doesn't automatically apply @ViewBuilder to send back multiple views.
    /// Options to fix this are Stacks, Groups, or adding @Viewbuilder attribute manually
    @ViewBuilder var spells: some View {
        Text("Lumos")
        Text("Obliviate")
    }
    
    var body: some View {
        VStack {
            // Modifiers can be directly applied to the properties
            motto1
                .foregroundColor(.red)
            motto2
                .foregroundColor(.blue)
            motto3
                .foregroundColor(Color(red: 0, green: 0.5, blue: 0.2))
            spells
                .background(AngularGradient(colors: [.red,.green,.blue], center: .center))
        }
    }
}

struct ViewsAsProps_Previews: PreviewProvider {
    static var previews: some View {
        ViewsAsProps()
    }
}
