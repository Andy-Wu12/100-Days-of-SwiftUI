//
//  CustomDivider.swift
//  Moonshot
//
//  Created by Andy Wu on 12/22/22.
//

import SwiftUI

struct CustomDivider: View {
    let frameHeight: CGFloat
    let foregroundColor: Color
    
    var body: some View {
        Rectangle()
            .frame(height: frameHeight)
            .foregroundColor(foregroundColor)
    }
}

struct CustomDivider_Previews: PreviewProvider {
    static var previews: some View {
        CustomDivider(frameHeight: 2, foregroundColor: .lightBackground)
    }
}
