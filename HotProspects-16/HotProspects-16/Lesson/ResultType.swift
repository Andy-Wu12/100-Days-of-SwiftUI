//
//  ResultType.swift
//  HotProspects-16
//
//  Created by Andy Wu on 2/25/23.
//

import SwiftUI

/*
    Swift provides a special type called Result that allows us to encapsulate either
    a successful value or some kind of error, all in a single piece of data.
*/
struct ResultType: View {
    @State private var output = ""
    
    var body: some View {
        Text(output)
            .task {
                await fetchReadings()
            }
    }
    
    func fetchReadings() async {
        // This setup provides flexibility for passing around or cancelling if needed
        let fetchTask = Task { () -> String in
            let url = URL(string: "https://hws.dev/readings.json")!
            let (data, _) = try await URLSession.shared.data(from: url)
            let readings = try JSONDecoder().decode([Double].self, from: data)
            return "Found \(readings.count) readings"
        }
        
        // Read the result from a Task
        let result = await fetchTask.result
        
        // Since our return value from fetchTask is string, our result type is Result<String, Error>
        // We can handle the Result like below
//        do {
//            output = try result.get()
//        } catch {
//            output = "Error: \(error.localizedDescription)"
//        }
        
        // An alternative is to switch on the Result and check for .success or .failure
        switch result {
        case .success(let str):
            output = str
        case .failure(let error):
            output = "Error: \(error.localizedDescription)"
        }
    }
}

struct ResultType_Previews: PreviewProvider {
    static var previews: some View {
        ResultType()
    }
}
