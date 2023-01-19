//
//  URLSessionAndAsync.swift
//  CupcakeCorner
//
//  Created by Andy Wu on 1/7/23.
//

import SwiftUI

/*
    iOS gives built-in tools for sending and receiving data from internet,
    which combined with Codable support makes it possible to convert Swift objects to JSON for sending,
    and receive JSON back for converting to Swift objects.
*/
struct URLSessionAndAsync: View {
    @State private var results = [Result]()
    
    var body: some View {
        List(results, id: \.trackId) { item in
            VStack(alignment: .leading) {
                Text(item.trackName)
                    .font(.headline)
                Text(item.collectionName)
            }
        }
        // Cannot use onAppear() since it expects synchronous function
        .task {
            await loadData()
        }
    }
    
    func loadData() async {
        // Create URL we want to read from
        guard let url = URL(string: "https://itunes.apple.com/search?term=ariana+grande&entity=song") else {
            print("Invalid URL")
            return
        }
        do {
            /*
             return value from data(from:) is a tuple containing data from IRL and
             metadata describing how the request went.
             Since we don't need the metadata here, we just toss it away with '_'
            */
            
            let (data, _) = try await URLSession.shared.data(from: url)
            if let decodedResponse = try? JSONDecoder().decode(Response.self, from: data) {
                results = decodedResponse.results
            }
        } catch {
            print("Invalid data")
        }
    }
}

struct Response: Codable {
    var results: [Result]
}

struct Result: Codable {
    var trackId: Int
    var trackName: String
    var collectionName: String
}

struct URLSessionAndAsync_Previews: PreviewProvider {
    static var previews: some View {
        URLSessionAndAsync()
    }
}
