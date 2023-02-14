//
//  ContentView-ViewModel.swift
//  BucketList-14
//
//  Created by Andy Wu on 2/13/23.
//

import MapKit
import LocalAuthentication

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
        @Published var isUnlocked = false
        
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
        
        func authenticate() {
            let context = LAContext()
            var error: NSError?
            
            if context.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: &error) {
                let reason = "Authenticate yourself to unlock your saved locations"
                
                context.evaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, localizedReason: reason) { success, authenticationError in
                    if success {
                        // Need this to run on Main Actor to make it safe for UI updates
//                        self.isUnlocked = true
                        
                        // Start a new background task then immediately use that task
                        // to queue up some owrk on the main actor
                        Task {
                            // This bounces to a background task, then back to the main actor
//                            await MainActor.run {
                            
                            // This immediately runs the new tasks on the main actor
                            Task { @MainActor in
                                self.isUnlocked = true
                            }
                        }
                    } else {
                        // error
                    }
                }
            } else {
                // no biometrics
            }
        }
    }
}
