//
//  PredatorMap.swift
//  JurassicParkApexPredators
//
//  Created by Victor Emanuel Ribeiro Silva on 20/03/25.
//

import MapKit
import SwiftUI

struct PredatorMap: View {
    @State var position: MapCameraPosition
    @State var satellite = false
    let predators = Predators()

    var body: some View {
        Map(position: $position) {
            ForEach(predators.apexPredators) {
                predator in
                Annotation(
                    predator.name,
                    coordinate: predator.location
                ) {
                    Image(predator.image)
                        .resizable()
                        .scaledToFit()
                        .frame(height: 100)
                        .shadow(color: .white, radius: 3)
                        .scaleEffect(x: -1)
                }
            }
        }
        .mapStyle(
            satellite ?
                .imagery(elevation: .realistic) :
                .standard(elevation: .realistic)
        )
        .overlay(alignment: .bottomTrailing) {
            Button {
                satellite.toggle()
            } label: {
                Image(systemName: satellite ? "globe.americas.fill" : "globe.americas")
                    .font(.largeTitle)
                    .imageScale(.large)
                    .padding(3)
                    .background(.ultraThinMaterial)
                    .clipShape(.rect(cornerRadius: 7))
                    .shadow(radius: 3)
                    .padding()
            }
        }
    }
}

#Preview {
    let predator = Predators().allApexPredators[2]
    PredatorMap(
        position:
        .camera(
            MapCamera(
                centerCoordinate: predator.location,
                distance: 1000,
                heading: 250,
                pitch: 88
            )
        )
    ).preferredColorScheme(.dark)
}
