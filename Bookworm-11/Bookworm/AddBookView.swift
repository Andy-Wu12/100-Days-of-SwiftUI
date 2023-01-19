//
//  AddBookView.swift
//  Bookworm
//
//  Created by Andy Wu on 1/14/23.
//

import SwiftUI

struct AddBookView: View {
    @Environment(\.managedObjectContext) var moc
    @Environment(\.dismiss) var dismiss
    
    @State private var title = ""
    @State private var author = ""
    @State private var rating = 3
    @State private var genre = "Fantasy"
    @State private var review = ""
    
    @State private var invalidSubmission = false
    
    let genres = ["Fantasy", "Horror", "Kids", "Mystery", "Poetry", "Romance", "Thriller"]
    
    func isValidSubmission() -> Bool {
        !(title.isTrimmedEmpty() || author.isTrimmedEmpty() ||
          genre.isTrimmedEmpty())
    }
    
    var body: some View {
        NavigationView {
            Form {
                Section {
                    TextField("Name of book", text: $title)
                    TextField("Author's name", text: $author)
                    
                    Picker("Genre", selection: $genre) {
                        ForEach(genres, id: \.self) {
                            Text($0)
                        }
                    }
                }
                
                Section {
                    TextEditor(text: $review)
                    RatingView(rating: $rating)
                } header: {
                    Text("Leave a review")
                }
                
                Section {
                    Button("Save") {
                        // Create Book instance using form values,
                        // then save using managed object context
                        let newBook = Book(context: moc)
                        newBook.id = UUID()
                        newBook.title = title
                        newBook.author = author
                        newBook.rating = Int16(rating)
                        newBook.genre = genre
                        newBook.review = review
                        newBook.date = Date.now
                        
                        try? moc.save()
                        dismiss()
                    }
                    .disabled(!isValidSubmission())
                }
            }
            .navigationTitle("Add Book")
        }
    }
}

struct AddBookView_Previews: PreviewProvider {
    static var previews: some View {
        AddBookView()
    }
}
