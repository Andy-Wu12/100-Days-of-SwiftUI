//
//  ContentView.swift
//  Bookworm
//
//  Created by Andy Wu on 1/13/23.
//

import SwiftUI

struct ContentView: View {
    @Environment(\.managedObjectContext) var moc
    @FetchRequest(sortDescriptors: [
        SortDescriptor(\.title),
        SortDescriptor(\.author)
    ]) var books: FetchedResults<Book>
    
    @State private var showingAddScreen = false
    
    func deleteBooks(at offsets: IndexSet) {
        for offset in offsets {
            // Find book in our fetch request
            let book = books[offset]
            
            // Delete it from context
            moc.delete(book)
        }
        
        try? moc.save()
    }
    
    var body: some View {
        NavigationView {
            List {
                ForEach(books) { book in
                    NavigationLink {
                        BookDetailView(book: book)
                    } label: {
                        HStack {
                            EmojiRatingView(rating: book.rating)
                                .font(.largeTitle)
                            
                            VStack(alignment: .leading) {
                                Text(book.title ?? "Unknown Title")
                                        .font(.headline)
                                        .foregroundColor(book.rating == 1 ? .red :
                                                            book.rating == 5 ? .green : .yellow)
                                Text(book.author ?? "Unkown Author")
                                    .foregroundColor(.secondary)
                                Text(book.date?.formatted(.dateTime.month().day().year()) ?? "Date added unknown")
                            }
                        }
                    }
                }
                .onDelete(perform: deleteBooks)
            }
                .navigationTitle("Bookworm")
                .toolbar {
                    ToolbarItem(placement: .navigationBarTrailing) {
                        Button {
                            showingAddScreen.toggle()
                        } label: {
                            Label("Add Book", systemImage: "plus")
                        }
                    }
                    ToolbarItem(placement: .navigationBarLeading) {
                        EditButton()
                    }
                }
                .sheet(isPresented: $showingAddScreen) {
                    AddBookView()
                }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
