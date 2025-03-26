//
//  EpisodeView.swift
//  BreakingBadQuotes
//
//  Created by Victor Emanuel Ribeiro Silva on 26/03/25.
//

import SwiftUI

struct EpisodeView: View {
    let episode: Episode

    var body: some View {
        VStack(alignment: .leading) {
            Text(episode.title).font(.largeTitle)

            Text(episode.seasonEpisode).font(.title)

            AsyncImage(url: episode.image) {
                image in
                image.resizable().scaledToFit().clipShape(.rect(cornerRadius: 15))
            } placeholder: {
                ProgressView()
            }

            Text(episode.synopsis)
                .font(.title3)
                .minimumScaleFactor(0.5)
                .padding(.bottom)

            Text("Written By: \(episode.writtenBy)")

            Text("Directed By: \(episode.directedBy)")

            Text("Aired: \(episode.airDate)")

        }.padding()
            .foregroundStyle(.white)
            .background(.black.opacity(0.6))
            .clipShape(.rect(cornerRadius: 25))
            .padding(.horizontal)
    }
}

#Preview {
    EpisodeView(
        episode: ViewModel().episode
    )
}
