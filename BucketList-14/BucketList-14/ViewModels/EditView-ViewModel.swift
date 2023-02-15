//
//  EditView-ViewModel.swift
//  BucketList-14
//
//  Created by Andy Wu on 2/14/23.
//

import SwiftUI

extension EditView {
    
    @MainActor class ViewModel: ObservableObject {
        private var location: MapLocation
        // Init props
        @Published var name: String
        @Published var description: String
        
        // Network request props
        @Published var loadingState = LoadingState.loading
        @Published var pages = [Page]()
        
        init(location: MapLocation) {
            self.location = location
            name = location.name
            description = location.description
        }
        
        func fetchNearbyPlaces() async {
            let urlString = "https://en.wikipedia.org/w/api.php?ggscoord=\(self.location.coordinate.latitude)%7C\(self.location.coordinate.longitude)&action=query&prop=coordinates%7Cpageimages%7Cpageterms&colimit=50&piprop=thumbnail&pithumbsize=500&pilimit=50&wbptterms=description&generator=geosearch&ggsradius=10000&ggslimit=50&format=json"
            
            guard let url = URL(string: urlString) else {
                print("Bad URL: \(urlString)")
                return
            }
            
            do {
                let (data, _) = try await URLSession.shared.data(from: url)
                
                // Data received
                let items = try JSONDecoder().decode(Result.self, from: data)
                
                // success - convert array values to our pages array
                self.pages = items.query.pages.values.sorted()
                self.loadingState = .loaded
            } catch {
                // if we're still here it means the request failed somehow
                self.loadingState = .failed
            }
        }
    }
}
