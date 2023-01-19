//
//  Codable.swift
//  iExpense
//
//  Created by Andy Wu on 12/15/22.
//

import SwiftUI

// Codable
/// Protocol designed specifically for ARCHIVING and UNARCHVING data
/// Fancy way of saying "converting objects to plain text and back again"
struct Employee: Codable {
    let firstName: String
    let lastName: String
}

struct ArchivingWithCodable: View {
    @State private var employee = Employee(firstName: "Dwight", lastName: "Schrute")
    
    @State private var fnameInput = ""
    @State private var lnameInput = ""
    @State private var statusMessage = ""
    
    var body: some View {
        VStack {
            TextField("First name: ", text: $fnameInput)
            TextField("Last name: ", text: $lnameInput)
            Text(statusMessage)
            Spacer()
            Button("Save User") {
                let newEmployee = Employee(firstName: fnameInput, lastName: lnameInput)
                let encoder = JSONEncoder()
                
                if let data = try? encoder.encode(newEmployee) {
                    UserDefaults.standard.set(data, forKey: "User")
                }
                statusMessage = "Saved \(fnameInput) \(lnameInput)"
            }
            Spacer()
            Button("Load User") {
                let decoder = JSONDecoder()
                
                if let data = try? decoder.decode(Employee.self, from: UserDefaults.standard.data(forKey: "User")!) {
                    // Load successful
                    employee = data
                    statusMessage = "Loaded \(employee.firstName) \(employee.lastName)"
                }
            }
            Spacer()
        }
    }
}

struct Codable_Previews: PreviewProvider {
    static var previews: some View {
        ArchivingWithCodable()
    }
}
