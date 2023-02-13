//
//  ContentView-ViewModel.swift
//  BucketList-14
//
//  Created by Andy Wu on 2/13/23.
//

import MapKit

/*
 MVVM stands for Model View View-Model.
 This is an architectural design pattern that helps us separate logic from layout.
*/


// The ViewModel for ContentView
extension ContentView {
    // This class will report changes back to any SwiftUI view that's watching
    /*
     The main actor is responsible for running all user interface updates
     and adding this attribute to the class means we want all its code -
     anytime it runs anything, unless we specific otherwise - to run on this main actor
    */
    @MainActor class ViewModel: ObservableObject {
        @Published var mapRegion = MKCoordinateRegion(
            center: CLLocationCoordinate2D(latitude: 50, longitude: 0),
            span: MKCoordinateSpan(latitudeDelta: 25, longitudeDelta: 25))
        
        // Only this class can WRITE locations
        @Published private(set) var locations: [MapLocation]
        @Published var selectedPlace: MapLocation?
        
        let savePath = FileManager.documentsDirectory.appendingPathComponent("SavedPlaces")
        
        init() {
            do {
                let data = try Data(contentsOf: savePath)
                locations = try JSONDecoder().decode([MapLocation].self, from: data)
            } catch {
                locations = []
            }
        }
        
        func addLocation() {
            let newLocation = MapLocation(id: UUID(), name: "New location", description: "", latitude: mapRegion.center.latitude, longitude: mapRegion.center.longitude)
            locations.append(newLocation)
            save()
        }
        
        func update(location: MapLocation) {
            guard let selectedPlace = selectedPlace else { return }
            
            if let index = locations.firstIndex(of: selectedPlace) {
                locations[index] = location
                save()
            }
        }
        
        func save() {
            do {
                let data = try JSONEncoder().encode(locations)
                // .completeFileProtection ensures file is stored with strong encryption and
                // readable only when unlocked (another different problem in itself)
                try data.write(to: savePath, options: [.atomic, .completeFileProtection])
            } catch {
                print("Unable to save data.")
            }
        }
    }
}
