//
//  ContentView.swift
//  Moonshot
//
//  Created by Varun Kumar Raghav on 17/09/21.
//

import SwiftUI

struct ContentView: View {
    let astronauts:[Astronaut] = Bundle.main.decode("astronauts.json")
    let missions:[Mission] = Bundle.main.decode("missions.json")
    @State private var isShowingDates = false
    var body: some View {
        NavigationView{
            List(missions){ mission in
                NavigationLink(destination: MissionView(mission: mission, astronauts: self.astronauts, missions: missions)){
                    Image(mission.image)
                        .resizable()
                       // .aspectRatio(contentMode: .fit)
                        .scaledToFit()
                        .frame(width: 44, height: 44)
                    VStack(alignment: .leading){
                        Text(mission.displayName)
                            .font(.headline)
                        if isShowingDates{
                            Text(mission.formattedLaunchDate)
                        }else{
                            Text(mission.crewNames)
                        }
                        
                    }
                }
                
            }
            
            .navigationBarTitle("Moonshot")
            .navigationBarItems(trailing: Toggle(isOn: $isShowingDates, label: {
                    Text("Show Dates")
                
            }))
        }
    }
}
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
