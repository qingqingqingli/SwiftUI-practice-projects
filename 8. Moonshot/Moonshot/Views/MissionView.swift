//
//  MissionView.swift
//

import SwiftUI

struct MissionView: View {
    let mission: Mission
    let crew: [CrewMember]
    
    init(mission: Mission, astronauts: [String: Astronaut]) {
        self.mission = mission
        
        self.crew = mission.crew.map { member in
            if let astronaut = astronauts[member.name] {
                return CrewMember(role: member.role, astronaut: astronaut)
            } else {
                // code mapping shouldn't go wrong therefore fatalError
                fatalError("Missing \(member.name)")
            }
        }
    }
    
    @ViewBuilder
    var divider: some View {
        Rectangle()
            .frame(height: 2)
            .foregroundColor(.lightBackground)
            .padding(.vertical)
    }
    
    @ViewBuilder
    var crewInfoHStack: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack {
                ForEach(crew, id: \.role) { crewMember in
                    NavigationLink {
                        AstronautView(astronaut: crewMember.astronaut)
                    } label: {
                        HStack {
                            Image(crewMember.astronaut.id)
                                .resizable()
                                .frame(width: 104, height: 72)
                                .clipShape(Capsule())
                                .overlay(
                                    Capsule()
                                        .strokeBorder(.white, lineWidth: 1)
                                )
                            
                            VStack(alignment: .leading) {
                                Text(crewMember.astronaut.name)
                                    .foregroundColor(.white)
                                    .font(.headline)
                                Text(crewMember.role)
                                    .foregroundColor(.secondary)
                            }
                        }
                        .padding(.horizontal)
                    }
                }
            }
        }
    }
    
    @ViewBuilder
    var missionDetailVStack: some View {
        VStack(alignment: .leading) {
            Text("Mission highlights")
                .font(.title.bold())
                .padding(.bottom, 5)
            
            divider
            
            Text(mission.description)
            
            divider
            
            Text("Crew")
                .font(.title.bold())
                .padding(.bottom, 5)
        }
        .padding(.horizontal)
    }
    
    var body: some View {
        GeometryReader { geometry in
            ScrollView(showsIndicators: false) {
                VStack {
                    Image(mission.image)
                        .resizable()
                        .scaledToFit()
                        .frame(maxWidth: geometry.size.width * 0.6)
                        .padding(.top)
                    
                    HStack {
                        Image(systemName: "calendar")
                        Text(mission.formattedLaunchDate)
                            .font(.headline.bold())
                            .padding(.vertical)
                    }
                    
                    missionDetailVStack
                    crewInfoHStack
                }
                .padding(.bottom)
            }
        }
        .navigationTitle(mission.displayName)
        .navigationBarTitleDisplayMode(.inline)
        .background(.darkBackground)
        .navigationViewStyle(.stack)
    }
}

struct MissionView_Previews: PreviewProvider {
    
    static let missions: [Mission] = Bundle.main.decode("missions.json")
    static let astronauts: [String: Astronaut] = Bundle.main.decode("astronauts.json")
    
    static var previews: some View {
        MissionView(mission: missions[1], astronauts: astronauts)
            .preferredColorScheme(.dark)
    }
}
