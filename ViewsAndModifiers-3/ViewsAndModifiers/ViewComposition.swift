//
//  ViewComposition.swift
//  ViewsAndModifiers
//
//  Created by Andy Wu on 12/8/22.
//

import SwiftUI

struct ViewComposition: View {
    // ViewComposition
    
    /// Breaking down complex views into smaller views w/o having performance impact.
    var body: some View {
       VStack(spacing: 10) {
           /// These two text views are identical apart from their text
           /// so we can create a new custom view for them (CapsuleText) below
           Text("First")
               .font(.largeTitle)
               .padding()
               .foregroundColor(.white)
               .background(.blue)
               .clipShape(Capsule())

           Text("Second")
               .font(.largeTitle)
               .padding()
               .foregroundColor(.white)
               .background(.blue)
               .clipShape(Capsule())
       }
        /// We can now use CapsuleText inside our main view like this
        VStack(spacing: 10) {
            Text("Custom view section")
            CapsuleText(text: "First")
            /// Duplicate modifiers here do not affect the original
            /// You can remove the original modifier in the custom view and the below will work
            /// That is also the way to apply customization to different instances if needed
            CapsuleText(text: "Second")
                .foregroundColor(.yellow)
        }
        
    }
}

struct CapsuleText: View {
    var text: String
    
    var body: some View {
        Text(text)
            /// Specific modifiers here can be removed to allow for instance-specific customizations
            .font(.largeTitle)
            .padding()
            .foregroundColor(.white)
            .background(.blue)
            .clipShape(Capsule())
    }
}


struct ViewComposition_Previews: PreviewProvider {
    static var previews: some View {
        ViewComposition()
    }
}
