//
//  AstronautView.swift
//  Moonshot
//
//  Created by Varun Kumar Raghav on 24/09/21.
//

import SwiftUI

struct AstronautView: View {
    let astronauts:[Astronaut] = Bundle.main.decode("astronauts.json")
    let missions:[Mission]
    var astronaut: Astronaut
    var body: some View {
        GeometryReader{ geometry in
            ScrollView(.vertical){
                VStack{
                    Image(self.astronaut.id)
                        .resizable()
                        .scaledToFit()
                        .frame(width: geometry.size.width )
                        .padding(.top)
                    Text(self.astronaut.description)
                        .padding()
                        .layoutPriority(1)
                    List(missions){ mission in
                            Image(mission.image)
                                .resizable()
                               // .aspectRatio(contentMode: .fit)
                                .scaledToFit()
                                .frame(width: 44, height: 44)
                            VStack(alignment: .leading){
                                Text(mission.displayName)
                                    .font(.headline)
                                Text(mission.formattedLaunchDate)
                            
                        }
                        
                    }
                }
            }
        }.navigationBarTitle(Text(self.astronaut.name), displayMode: .inline)
    }
    init(astronaut: Astronaut, missions: [Mission]) {
        self.astronaut = astronaut
        var matches = [Mission]()
        
        for mission in missions{
            if let _ = mission.crew.first(where: {$0.name == astronaut.id}){
                matches.append(mission)
            }
//            else{
//                fatalError("no mission found")
//            }
//        for mission in missions{
//            for member in mission.crew{
//                if member.name == astronaut.id {
//                    matches.append(mission)
//                }
//            }
        }
        self.missions = matches
    }
}

struct AstronautView_Previews: PreviewProvider {
    static let missions:[Mission] = Bundle.main.decode("missions.json")
    static let astronauts:[Astronaut] = Bundle.main.decode("astronauts.json")
    static var previews: some View {
        AstronautView(astronaut: self.astronauts[0], missions: missions)
    }
}
