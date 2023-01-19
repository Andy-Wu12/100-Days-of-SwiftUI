//
//  CustomModifiers.swift
//  ViewsAndModifiers
//
//  Created by Andy Wu on 12/8/22.
//

import SwiftUI

struct CustomModifiers: View {
    var body: some View {
        /// We can use the custom Title() modifier like below
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
            .modifier(Title())
        // With the view extension set up, we can call it as such
        Text("Hello, World 2!")
            .titleStyle()
        Text("Copyright text")
            .frame(width: 300, height: 200)
            .watermarked(with: "Copyright")
    }
}

/// This is a way to set up alternatively calling the custom modifier
extension View {
    func titleStyle() -> some View {
        modifier(Title())
    }
    func watermarked(with text: String) -> some View {
        modifier(Watermark(text: text))
    }
}

/// To create a custom modifier, create a new struct that conforms to the ViewModifier protocol
/// Has one requirement, a method called body that accepts
/// whatever content it's being given to work with and must return "some View"
/// The example below says that all titles in our app should have a particular style
struct Title: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.largeTitle)
            .foregroundColor(.white)
            .padding()
            .background(.blue)
            .clipShape(RoundedRectangle(cornerRadius: 10))
    }
}

/// Custom modifiers can do more than just apply existing modifiers
/// They can also create new view structure, as needed.
/// Remember that modifiers return NEW OBJECTS rather than modifying existing ones
/// So we could create one taht embeds the view in a stack and adds another view
struct Watermark: ViewModifier {
    var text: String
    
    func body(content: Content) -> some View {
        ZStack(alignment: .bottomTrailing) {
            content
            Text(text)
                .font(.caption)
                .foregroundColor(.white)
                .padding(5)
                .background(.black)
        }
    }
}

/// Custom view modifier vs extending View with new method
/// Custom view modifiers can have their own stroed properties, whereas extensions to View cannot
struct CustomModifiers_Previews: PreviewProvider {
    static var previews: some View {
        CustomModifiers()
    }
}
