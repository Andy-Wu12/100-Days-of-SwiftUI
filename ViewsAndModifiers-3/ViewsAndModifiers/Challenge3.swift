//
//  Challenge3.swift
//  ViewsAndModifiers
//
//  Created by Andy Wu on 12/8/22.
//

import SwiftUI

struct Challenge3: View {
    var body: some View {
        Text("This is the title")
            .largeTitle()
    }
}

struct LargeTitle: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.system(size: 50, weight: .bold))
            .foregroundColor(.blue)
            .textCase(.uppercase)
            .clipShape(Rectangle())
    }
}

extension View {
    func largeTitle() -> some View {
        modifier(LargeTitle())
    }
}

struct Challenge3_Previews: PreviewProvider {
    static var previews: some View {
        Challenge3()
    }
}
