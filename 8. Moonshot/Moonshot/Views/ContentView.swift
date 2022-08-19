//
//  ContentView.swift
//

import SwiftUI

struct ContentView: View {
    
    let astronauts: [String: Astronaut] = Bundle.main.decode("astronauts.json")
    let missions: [Mission] = Bundle.main.decode("missions.json")
    
    @State private var showAsList = false
    
    var body: some View {
        NavigationView {
            Group {
                if showAsList {
                    MissionsListView(missions: missions,astronauts: astronauts)
                } else {
                    MissionsGridView(missions: missions,astronauts: astronauts)
                }
            }
            .navigationTitle("Moonshot")
            .background(.darkBackground)
            .preferredColorScheme(.dark)
            .toolbar {
                Toggle(isOn: $showAsList) {
                    Text("Show list view")
                }
                .toggleStyle(.switch)
                .tint(.blue)
            }
        }
        .navigationViewStyle(.stack)
    }
}

struct Astronaut: Codable, Identifiable {
    let id: String
    let name: String
    let description: String
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
