//
//  GeometryReader.swift
//  Moonshot
//
//  Created by Andy Wu on 12/18/22.
//

import SwiftUI

struct GeometryReaderLesson: View {
    var body: some View {
        GeometryReader { geo in
            Image("Bird")
                .resizable()
                .scaledToFit()
                .frame(width: geo.size.width * 0.8)
                // Helps center view inside GeometryReader
                .frame(width: geo.size.width, height: geo.size.height)
        }
    }
}

struct GeometryReaderLesson_Previews: PreviewProvider {
    static var previews: some View {
        GeometryReaderLesson()
    }
}
