//
//  ApexPredatorController.swift
//  JurassicParkApex
//
//  Created by Neeraj Gupta on 27/04/23.
//

import Foundation

class ApexPredatorController {
    var allApexPredators: [ApexPredator] = []
    var apexPredators: [ApexPredator] = []
    let typeFilters = ["All", "Land", "Air", "Sea"]
    
    init() {
        decodeApexPredatorData()
    }
    
    func decodeApexPredatorData() {
        if let url = Bundle.main.url(forResource: "jpapexpredators", withExtension: "json") {
            do {
                let data = try Data(contentsOf: url)
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                allApexPredators = try decoder.decode([ApexPredator].self, from: data)
                apexPredators = allApexPredators
            } catch {
                print("Error decoding json data \(error)")
            }
        }
    }
    
    func typeIcon(for type: String) -> String {
        switch type {
        case "All": return "square.stack.3d.up.fill"
        case "Land": return "leaf.fill"
        case "Air": return "wind"
        case "Sea": return "drop.fill"
        default: return "questionmark"
        }
    }
    
    func filterBy(type: String) {
        switch type {
        case "Land", "Air", "Sea":
            apexPredators = allApexPredators.filter {
                $0.type == type.lowercased()
            }
        default:
            apexPredators = allApexPredators
        }
    }
    
    func sortByAlphabetical() {
        apexPredators.sort(by: {$0.name < $1.name})
    }
    
    func sortByMovieAppearance() {
        apexPredators.sort(by: {$0.id < $1.id})
    }
}
