//
//  Expense.swift
//  iExpense
//
//  Created by Andy Wu on 12/16/22.
//

import Foundation

struct ExpenseItem: Identifiable, Codable {
    var id = UUID()
    let date: Date
    let name: String
    let type: String
    let amount: Double
    
    // Possible enhancement is to let users add additonal types
    static var types = ["Personal", "Business", "Family"]
}

class Expenses: ObservableObject {
    static let expenseItemsKey = "ExpenseItems"
    
    @Published var items = [ExpenseItem]() {
        didSet {
            if let encoded = try? JSONEncoder().encode(items) {
                UserDefaults.standard.set(encoded, forKey: Expenses.expenseItemsKey)
            }
        }
    }
    
    init() {
        if let savedItems = UserDefaults.standard.data(forKey: Expenses.expenseItemsKey) {
            // Note .self here refers to the TYPE OBJECT itself, i.e. a list of ExpenseItems
            if let decodedItems = try? JSONDecoder().decode([ExpenseItem].self, from: savedItems) {
                items = decodedItems
                return
            }
        }
        // If decoding process fails...
        items = []
    }
}
