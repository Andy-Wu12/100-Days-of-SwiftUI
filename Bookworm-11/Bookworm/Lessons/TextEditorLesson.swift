//
//  TextEditorLesson.swift
//  Bookworm
//
//  Created by Andy Wu on 1/13/23.
//

import SwiftUI

struct TextEditorLesson: View {
    // Never use @AppStorage for secure data
    @AppStorage("notes") private var notes = ""
    
    var body: some View {
        NavigationView {
            TextEditor(text: $notes)
                .navigationTitle("Notes")
                .padding()
                .background(.blue)
        }
    }
}

struct TextEditorLesson_Previews: PreviewProvider {
    static var previews: some View {
        TextEditorLesson()
    }
}
