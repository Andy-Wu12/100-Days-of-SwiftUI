//
//  ContentView.swift
//  Moonshot
//
//  Created by Andy Wu on 12/18/22.
//

import SwiftUI

struct ContentView: View {
    @State var displayAsGrid = true
    
    let astronauts: [String: Astronaut] = Bundle.main.decode("astronauts.json")
    let missions: [Mission] = Bundle.main.decode("missions.json")
    
    let columns = [
        GridItem(.adaptive(minimum: 150))
    ]
    
    var body: some View {
        NavigationView {
            Group {
                if displayAsGrid {
                    BadgeGridView(missions: missions, astronauts: astronauts, layout: columns)
                        
                } else {
                    BadgeListView(missions: missions, astronauts: astronauts)
                }
            }
            .toolbar {
                Button(displayAsGrid ? "Show List View" : "Show Grid View") {
                    displayAsGrid.toggle()
                }
            }
            .navigationTitle("Moonshot")
            .background(.darkBackground)
            .preferredColorScheme(.dark)
        }
    }
}

struct BadgeGridView: View {
    let missions: [Mission]
    let astronauts: [String: Astronaut]
    let layout: [GridItem]
    
    var body: some View {
        ScrollView {
            LazyVGrid(columns: layout) {
                ForEach(missions) { mission in
                    NavigationLink {
                        MissionView(mission: mission, astronauts: astronauts)
                    } label: {
                        VStack {
                            Image(mission.imageName)
                                .resizable()
                                .scaledToFit()
                                .frame(width: 100, height: 100)
                                .padding()
                            
                            VStack {
                                Text(mission.displayName)
                                    .font(.headline)
                                    .foregroundColor(.white)
                                Text(mission.formattedLaunchDate)
                                    .font(.caption)
                                    .foregroundColor(.white.opacity(0.5))
                            }
                            .padding(.vertical)
                            .frame(maxWidth: .infinity)
                            .background(.lightBackground)
                        }
                    }
                    .clipShape(RoundedRectangle(cornerRadius: 10))
                    .overlay(RoundedRectangle(cornerRadius: 10)
                        .stroke(.lightBackground)
                    )
                }
            }
            .padding([.horizontal, .bottom])
        }
    }
}

struct BadgeListView: View {
    let missions: [Mission]
    let astronauts: [String: Astronaut]
    
    var body: some View {
        List {
            ForEach(missions) { mission in
                NavigationLink {
                    MissionView(mission: mission, astronauts: astronauts)
                } label: {
                    HStack {
                        Image(mission.imageName)
                            .resizable()
                            .scaledToFit()
                            .frame(width: 100, height: 100)
                        VStack {
                            /*@START_MENU_TOKEN@*/Text(mission.displayName)/*@END_MENU_TOKEN@*/
                            Text(mission.formattedLaunchDate == "N/A" ? "" : mission.formattedLaunchDate)
                        }
                        .padding(.horizontal)
                    }
                }
                .listRowBackground(Color.darkBackground)
            }
        }
        .listStyle(.plain)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
