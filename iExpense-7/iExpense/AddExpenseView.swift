//
//  AddView.swift
//  iExpense
//
//  Created by Andy Wu on 12/16/22.
//

import SwiftUI

struct AddExpenseView: View {
    @Environment(\.dismiss) var dismiss
    @State private var name = ""
    @State private var type = "Personal"
    @State private var amount = 0.0
    
    @State private var errorMessage = ""
    @State private var showErrorAlert = false
    
    // Below uses created instance from ContentView
    // Notice @ObservedObject instead of @StateObject
    @ObservedObject var expenses: Expenses
    
    var body: some View {
        NavigationView {
            Form {
                TextField("Name", text: $name)
                Picker("Type", selection: $type) {
                    ForEach(ExpenseItem.types, id: \.self) {
                        Text($0)
                    }
                }
                TextField("Amount", value: $amount, format: currencyCode)
                    .keyboardType(.decimalPad)
                    
            }
            .alert("Error", isPresented: $showErrorAlert) {
                Button("OK", action: {showErrorAlert = false})
            } message: {
                Text(errorMessage)
            }
            .navigationTitle("Add New Expense")
            .toolbar {
                Button("Save") {
                    if name.count < 1 {
                        errorMessage = "Please enter a name for the expense"
                        showErrorAlert = true
                        return
                    }
                    else if amount <= 0.0 {
                        errorMessage = "Enter the cost of the expense"
                        showErrorAlert = true
                        return
                    }
                    
                    let item = ExpenseItem(date: Date.now, name: name, type: type, amount: amount)
                    expenses.items.append(item)
                    dismiss()
                }
            }
        }
    }
}

struct AddView_Previews: PreviewProvider {
    static var previews: some View {
        AddExpenseView(expenses: Expenses())
    }
}
