//
//  ComponentWithBinding.swift
//  Bookworm
//
//  Created by Andy Wu on 1/13/23.
//

import SwiftUI

struct ComponentWithBinding: View {
    @State private var rememberMe = false
    
    var body: some View {
        VStack {
            PushButton(title: "Remember Me", isOn: $rememberMe)
            Text(rememberMe ? "On" : "Off")
        }
    }
}

struct PushButton: View {
    let title: String
    /*
     @State here, even if set from an external source, is now local to this instance (i.e., one-way connection)
     */
//    @State var isOn: Bool
    
    /*
     Using @Binding allows us to create a two-way connection
     between PushButton and whatever else is using the same data
     (our conditional text in ComponentWithBinding)
     */
    @Binding var isOn: Bool
    
    var onColors = [Color.red, Color.yellow]
    var offColors = [Color(white: 0.6), Color(white: 0.4)]
    
    var body: some View {
        Button(title) {
            isOn.toggle()
        }
        .padding()
        .background(LinearGradient(gradient: Gradient(colors: isOn ? onColors : offColors), startPoint: .top, endPoint: .bottom))
        .foregroundColor(.white)
        .clipShape(Capsule())
        .shadow(radius: isOn ? 0 : 5)
    }
}

struct ComponentWithBinding_Previews: PreviewProvider {
    static var previews: some View {
        ComponentWithBinding()
    }
}
