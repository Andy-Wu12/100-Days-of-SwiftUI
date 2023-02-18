//
//  HidingAndGrouping.swift
//  Accessibility-15
//
//  Created by Andy Wu on 2/17/23.
//

import SwiftUI

/*
    It's important to hide unimportant parts of our UI or group several views as one
    to allow VoiceOvers to both navigate through it as quickly as possible and prevent reading unhelpful descriptions.
    
*/

struct HidingAndGrouping: View {
    // We can tell SwiftUI that a particular image is just there to make the UI look better
    // by using Image(decorative:).
    // The image will be accessible if it has important traits such as .isButtton -
        // it will say "button" when highlighted but it DOESN'T read out the image's filename
        // unless you add a label or a hint manually
    var body: some View {
        Image(decorative: "ales-krivec-15949")
            // Makes any view completely invisible to the accessibility system
//            .accessibilityHidden(true)
        
        // VoiceOver sees this as two unrelated text views, so will read
        // "Your Score is" or "1000" depending on what the user has selected
        VStack {
            Text("Your score is")
            Text("1000")
                .font(.title)
        }
        /*
             children: .combine is great for when child views contain separate information
             We are using .ignore here so that the child views are invisible to VoiceOver
                 and we can provide a custom label instead
             Using .combine adds a pause between the two pieces of text
             Using .ignore and a custom label means the text is read all at once.
         
            Note: .ignore is the default parameter so you can get the same effect with .accessibilityElement()
         */
        .accessibilityElement(children: .ignore)
        .accessibilityLabel("Your score is 1000")
    }
}

struct HidingAndGrouping_Previews: PreviewProvider {
    static var previews: some View {
        HidingAndGrouping()
    }
}
