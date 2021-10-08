//
//  MissionView.swift
//  Moonshot
//
//  Created by Varun Kumar Raghav on 23/09/21.
//

import SwiftUI
struct CrewMember {
    let role: String
    let astranaut: Astronaut
}
//enum RoleType{
//    case
//}

struct MissionView: View {
    let astronauts: [CrewMember]
    let missions: [Mission]
    let mission: Mission
 //   @State private var isCommander = false
    
    var body: some View{
        GeometryReader { geometry in
            ScrollView(.vertical){
                VStack{
                    Image(self.mission.image)
                        .resizable()
                        .scaledToFit()
                        .frame(maxWidth: geometry.size.width * 0.7)
                        .padding(.top)
                    
                    Text("Launched on : \(self.mission.formattedLaunchDate)")
                        .padding()
                    Text(self.mission.description)
                        .padding()
                    
                    ForEach(self.astronauts, id: \.role){ crewMember in
                        NavigationLink(destination: AstronautView(astronaut: crewMember.astranaut, missions: self.missions)){
                            HStack{
                                Image(crewMember.astranaut.id)
                                    .resizable()
                                    .frame(width: 83, height: 60)
                                    .clipShape(Capsule())
                                    .overlay(Capsule().stroke(Color.red, lineWidth: 2))
    //                                .clipShape(RoundedRectangle(cornerRadius: 25))
    //                                .overlay(RoundedRectangle(cornerRadius: 25).stroke(Color.green, lineWidth: 1))
                                VStack{
                                    if isCommander(astronautRole: crewMember.role)
                                    {
                                        Text(crewMember.astranaut.name)
                                            .font(.title3)
                                            .foregroundColor(.blue)
                                    }else{
                                        Text(crewMember.astranaut.name)
                                            .font(.headline)
                                    }
                                    Text(crewMember.role)
                                }
                                Spacer()
                            }.padding(.horizontal)
                        }.buttonStyle(PlainButtonStyle())
                    }
                    
                    Spacer(minLength: 25)
                }
            }
        }.navigationBarTitle(Text(mission.displayName), displayMode: .inline)
    }
    
    //Custom initializer
    
    init(mission: Mission, astronauts:[Astronaut], missions: [Mission]) {
        self.mission = mission
        self.missions = missions
        var matches = [CrewMember]()
        
        for memeber in mission.crew {
            if let match = astronauts.first(where: {$0.id == memeber.name}){
                matches.append(CrewMember(role: memeber.role, astranaut: match))
            }else{
                fatalError("Missing \(memeber)")
            }
        }
        self.astronauts = matches
    }
    
    func isCommander(astronautRole: String)-> Bool {
        switch astronautRole {
        case "Commander" :
            return true
        case "Command Pilot":
            return true
        default:
            return false
        }
    }
    
}
struct MissionView_Previews: PreviewProvider {
    static let missions:[Mission] = Bundle.main.decode("missions.json")
    static let astranauts:[Astronaut] = Bundle.main.decode("astronauts.json")
    static var previews: some View {
        MissionView(mission: missions[0], astronauts: astranauts, missions: missions)
    }
}
