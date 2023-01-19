//
//  ContentView.swift
//  iExpense
//
//  Created by Andy Wu on 12/15/22.
//

import SwiftUI

struct ContentView: View {
    // Create object to be shared with other views
    @StateObject var expenses = Expenses()
    @State private var showingAddExpense = false
    
    var body: some View {
        NavigationView {
            List {
                ForEach(ExpenseItem.types, id: \.self) { type in
                    ExpenseTypeSection(expenses: expenses, expenseType: type)
                }
            }
            .navigationTitle("iExpense")
            .toolbar {
                Button {
                    showingAddExpense = true
                } label: {
                    Image(systemName: "plus")
                }
            }
        }
        .sheet(isPresented: $showingAddExpense) {
            AddExpenseView(expenses: expenses)
        }
    }
        
}

struct ExpenseTypeSection: View {
    @ObservedObject var expenses: Expenses
    var expenseType: String
    
    var expenseItems: [ExpenseItem] {
        return expenses.items.filter { $0.type == expenseType }
    }
    
    var body: some View {
        // id: \.id not needed since we made Expense conform to Identifiable
        Section {
            ForEach(expenseItems) { item in
                HStack {
                    VStack(alignment: .leading) {
                        Text(item.date.formatted())
                        Text(item.name)
                            .font(.headline)
                    }
                    
                    Spacer()
                    ExpenseItemPrice(item: item)
                    
                }
            }
            .onDelete(perform: removeItems)
        } header: {
            Text(expenseType)
                .font(.headline)
        }
    }
    
    // Search # of expense items that match type before removing
    func removeItems(at offsets: IndexSet) {
        var countForType = offsets.first! + 1
        let expenseItems = expenses.items
        
        for i in 0..<expenseItems.count {
            if expenseItems[i].type == expenseType {
                countForType -= 1
            }
            if countForType == 0 {
                expenses.items.remove(atOffsets: [i])
            }
        }
    }
}

struct ExpenseItemPrice: View {
    var item: ExpenseItem
    
    var body: some View {
        if item.amount <= 10 {
            Text(item.amount, format: currencyCode)
                .foregroundColor(.green)
        }
        else if item.amount <= 100 {
            Text(item.amount, format: currencyCode)
                .foregroundColor(Color(red: 0.0, green: 0.5, blue: 0.5))
        }
        else {
            Text(item.amount, format: currencyCode)
                .foregroundColor(.red)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
