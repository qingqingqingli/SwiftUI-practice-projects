//
//  MissionsListView.swift
//

import SwiftUI

struct MissionsListView: View {
    let missions: [Mission]
    let astronauts: [String: Astronaut]
    
    var body: some View {
        GeometryReader { geometry in
            // TODO: Change background color of List in XCode 14
            List {
                ForEach(missions) { mission in
                    NavigationLink {
                        MissionView(mission: mission, astronauts: astronauts)
                    } label: {
                        HStack(spacing: 16) {
                            Image(mission.image)
                                .resizable()
                                .scaledToFit()
                                .frame(width: geometry.size.width * 0.2)
                            VStack(alignment: .leading, spacing: 8) {
                                Text(mission.displayName)
                                Text(mission.formattedLaunchDate)
                            }
                            .padding(.vertical)
                        }
                    }
                }
            }
        }
    }
}

struct MissionsListView_Previews: PreviewProvider {
    static let missions: [Mission] = Bundle.main.decode("missions.json")
    static let astronauts: [String: Astronaut] = Bundle.main.decode("astronauts.json")
    
    static var previews: some View {
        MissionsListView(missions: missions, astronauts: astronauts)
            .preferredColorScheme(.dark)
    }
}
