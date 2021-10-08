//
//  Mission.swift
//  Moonshot
//
//  Created by Varun Kumar Raghav on 18/09/21.
//

import Foundation


struct Mission: Identifiable, Codable {
    struct CrewRole: Codable {
        let name: String
        let role: String
    }
    let id: Int
    let launchDate: Date?
    let crew: [CrewRole]
    let description: String
    
    var crewNames:String{
        var names = String()
        for i in crew {
            names += i.name + "|"
        }
        return names.capitalized
    }
    var displayName: String{
        "Apollo \(id)"
    }
    var image: String{
        "apollo\(id)"
    }
    var formattedLaunchDate: String{
        if let launchDate = launchDate{
            let formatter = DateFormatter()
            formatter.dateStyle = .long
            return formatter.string(from: launchDate)
        }else{
            return " N/A "
        }
    }
}
