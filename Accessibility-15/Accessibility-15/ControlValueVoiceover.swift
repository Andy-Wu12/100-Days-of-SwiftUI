//
//  ControlValueVoiceover.swift
//  Accessibility-15
//
//  Created by Andy Wu on 2/18/23.
//

import SwiftUI

struct ControlValueVoiceover: View {
    @State private var value = 10
    
    var body: some View {
        // By default VoiceOver will just read increment / decrement, which is not a great experience.
        VStack {
            Text("value: \(value)")
            
            Button("Increment") {
                value += 1
            }
            
            Button("Decrement") {
                value -= 1
            }
        }
        // We can give iOS specific instructions to handle adjustments.
        // The modifiers below let the user select the whole VStack to have "Value: 10" read out
            // then swipe up or down to manipulate the value and have just the number read out.
        .accessibilityElement()
        .accessibilityLabel("Value")
        .accessibilityValue(String(value))
        .accessibilityAdjustableAction { direction in
            switch direction {
            case .increment:
                value += 1
            case .decrement:
                value -= 1
            default:
                print("Not handled.")
            }
        }
    }
}

struct ControlValueVoiceover_Previews: PreviewProvider {
    static var previews: some View {
        ControlValueVoiceover()
    }
}
