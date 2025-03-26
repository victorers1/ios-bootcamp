//
//  ApexPredator.swift
//  JurassicParkApexPredators
//
//  Created by Victor Emanuel Ribeiro Silva on 19/03/25.
//

import SwiftUI
import MapKit

struct ApexPredator: Decodable, Identifiable {
    let id: Int
    let name: String
    let type: APType
    let latitude: Double
    let longitude: Double
    let movies: [String]
    let movieScenes: [MovieScene]
    let link: String

    var image: String {
        name.replacingOccurrences(of: " ", with: "").lowercased()
    }

    struct MovieScene: Decodable, Identifiable {
        let id: Int
        let movie: String
        let sceneDescription: String
    }
    
    var location: CLLocationCoordinate2D {
        CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
    }
}

enum APType: String, Decodable, CaseIterable, Identifiable {
    var id: APType { self }

    case all
    case land
    case air
    case sea

    var background: Color {
        switch self {
        case .land:
            .brown
        case .air:
            .teal
        case .sea:
            .blue
        case .all:
            .black
        }
    }

    var icon: String {
        switch self {
        case .all:
            "square.stack.3d.up.fill"
        case .land:
            "leaf.fill"
        case .air:
            "wind"
        case .sea:
            "drop.fill"
        }
    }
}
