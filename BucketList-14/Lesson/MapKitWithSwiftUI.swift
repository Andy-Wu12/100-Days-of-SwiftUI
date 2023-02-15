//
//  MapKitWithSwiftUI.swift
//  BucketList-14
//
//  Created by Andy Wu on 2/9/23.
//

import SwiftUI
import MapKit

/*
    Showing a map means creating some state that stores
    the map's current center coord and zoom level.
    This is handled through the MKCoordinateRegion type
*/

/*
 There are a variety of extra options we can use when creating maps,
 but the most important is the ability to add annotations,
 which are markers that represent various places of our choosing.
 
 Takes at least three steps:
 
 1. Define new data type that contains your location
 2. Create array of those containing ALL your lcoations
 3. Add them as annotations in the map
*/

// 1
struct Location: Identifiable {
    let id = UUID()
    let name: String
    let coordinate: CLLocationCoordinate2D
}

struct MapKitWithSwiftUI: View {
    @State private var mapRegion = MKCoordinateRegion(
        center: CLLocationCoordinate2D(latitude: 51.5, longitude: -0.12),
        span: MKCoordinateSpan(latitudeDelta: 0.2, longitudeDelta: 0.2)
    )
    
    // 2
    let locations = [
        Location(name: "Buckingham Palace", coordinate: CLLocationCoordinate2D(latitude: 51.501, longitude: -0.141)),
        Location(name: "Tower of London", coordinate: CLLocationCoordinate2D(latitude: 51.508, longitude: -0.076))
    ]
    
    var body: some View {
        // 3
        NavigationView {
            Map(coordinateRegion: $mapRegion, annotationItems: locations) { location in
                // Annotation type that creates simple balloon with lat / long coord attached
                //            MapMarker(coordinate: location.coordinate)
                
                // Alternative option is MapAnnotation, which additionally accepts a custom SwiftUI view
                // This view can be used to customize annotation style, interactivty
                // and / or provide more detailed information about the location
                MapAnnotation(coordinate: location.coordinate) {
                    NavigationLink {
                        Text(location.name)
                    } label : {
                        Circle()
                            .stroke(.red, lineWidth: 3)
                            .frame(width: 44, height: 44)
//                            .onTapGesture {
//                                print("Tapped on \(location.name)")
//                            }
                    }
                }
            }
            .navigationTitle("London Explorer")
        }
    }
}

struct MapKitWithSwiftUI_Previews: PreviewProvider {
    static var previews: some View {
        MapKitWithSwiftUI()
    }
}
