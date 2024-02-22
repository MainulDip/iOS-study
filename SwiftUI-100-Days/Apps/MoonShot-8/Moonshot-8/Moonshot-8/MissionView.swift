//
//  MissionView.swift
//  Moonshot-8
//
//  Created by Mainul Dip on 2/14/24.
//

import SwiftUI

struct MissionView: View {
    
    let mission: Mission
    
    var body: some View {
        ScrollView {
            VStack {
                Image(mission.image)
                    .resizable()
                    .scaledToFit()
                    .containerRelativeFrame(.horizontal) { width, axis in
                        width * 0.6
                    }
                    .padding(.top)
                VStack(alignment: .leading) {
                    Text("Mission Highlights")
                        .font(.title.bold())
                        .padding(.bottom, 5)
                    
                    Text(mission.description)
                }
                .padding(.horizontal)
            }
        }
        .preferredColorScheme(.dark)
    }
}

struct CrewMember {
    let role: String
    let astronaut: Astronaut
}

#Preview {
    let missions: [Mission] = Bundle.main.decode("missions.json");
    return MissionView(mission: missions[0]);
    
    // MissionView(mission: Mission(id: 7, launchDate: nil, crew: [Mission.CrewRole(name: "Crew 7", role: "Role 7")], description: "Crew description"))
    
}
