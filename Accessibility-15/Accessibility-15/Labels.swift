//
//  Labels.swift
//  Accessibility-15
//
//  Created by Andy Wu on 2/17/23.
//

import SwiftUI

struct LabelsView: View {
    // VoiceOVer reads out the filenames by default.
    // This is undesirable when our names are like below
      // but we also cannot just rename every file to make it more descriptive
    let pictures = [
        "ales-krivec-15949",
        "galina-n-189483",
        "kevin-horstmann-141705",
        "nicolas-tissot-335096"
    ]
    
    let labels = [
        "Tulips",
        "Frozen tree buds",
        "Sunflowers",
        "Fireworks"
    ]
    
    @State private var selectedPicture = Int.random(in: 0...3)
    
    var body: some View {
        Image(pictures[selectedPicture])
            .resizable()
            .scaledToFit()
            .onTapGesture {
                selectedPicture = Int.random(in: 0...3)
            }
            /*
                 We can control what VoiceOver reads for a given view by attaching
                    .accessibilityLabel() and .accessibilityHint()
                 The LABEL is read immediately and should be a short piece of text that gets right to the point.
                     i.e. "Delete"
                 The HINT is read after a short delay and should provide more details
                     on what the view is there for.
                     i.e. "Deletes an email from your inbox"
            */
            .accessibilityLabel(labels[selectedPicture])
            // .accessibilityAddTraits() allows us to provide extra info to VoiceOver that describes how the view works
            // In our case, we can tell it our image is also a button (since we use onTapGesture)
            .accessibilityAddTraits(.isButton)
            // and remove iamge trait since it doesn't add much
            .accessibilityRemoveTraits(.isImage)
    }
}

struct LabelsView_Previews: PreviewProvider {
    static var previews: some View {
        LabelsView()
    }
}
