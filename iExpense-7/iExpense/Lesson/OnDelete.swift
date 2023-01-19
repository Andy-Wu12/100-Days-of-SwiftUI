//
//  onDelete.swift
//  iExpense
//
//  Created by Andy Wu on 12/15/22.
//

import SwiftUI

/// onDelete() modifier allows us to control how objects should be deleted from a collection.
struct OnDelete: View {
    @State private var numbers = [Int]()
    @State private var currentNumber = 1
    
    var body: some View {
        NavigationView {
            VStack {
                /// onDelete() modifier only exists on ForEach
                /// which is why we can't just have
                /// List(numbers, id: \.self) {
                ///     Text("row \($0)")
                /// }
                List {
                    ForEach(numbers, id: \.self) {
                        Text("Row \($0)")
                    }
                    .onDelete(perform: removeRows)
                }
                Button("Add Number") {
                    numbers.append(currentNumber)
                    currentNumber += 1
                }
            }
            .toolbar {
                // Allow user to delete rows more easily
                // (tap vs swipe)
                EditButton()
            }
        }
    }
    
    // onDelete() requires a method that takes a single param of type IndexSet.
    // This param is a set of sorted Ints telling us positions of all items in ForEach to remove
    func removeRows(at offsets: IndexSet) {
        numbers.remove(atOffsets: offsets)
    }
}

struct OnDelete_Previews: PreviewProvider {
    static var previews: some View {
        OnDelete()
    }
}
