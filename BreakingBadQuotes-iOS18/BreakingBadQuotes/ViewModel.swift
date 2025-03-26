//
//  ViewModel.swift
//  BreakingBadQuotes
//
//  Created by Victor Emanuel Ribeiro Silva on 24/03/25.
//

import Foundation

@Observable
@MainActor
class ViewModel {
    enum FetchStatus {
        case notStarted
        case fetching
        case successQuote
        case successEpisode
        case faild(error: Error)
    }

    private(set) var fetchStatus: FetchStatus = .notStarted

    private let fetcher = FetchService()

    var quote: Quote
    var character: Char
    var episode: Episode

    init() {
        let decoder = JSONDecoder()

        decoder.keyDecodingStrategy = .convertFromSnakeCase

        let quoteData = try! Data(
            contentsOf: Bundle.main.url(forResource: "samplequote", withExtension: "json")!
        )
        quote = try! decoder.decode(Quote.self, from: quoteData)

        let characterData = try! Data(
            contentsOf: Bundle.main.url(forResource: "samplecharacter", withExtension: "json")!
        )
        character = try! decoder.decode(Char.self, from: characterData)

        let episodeData = try! Data(
            contentsOf: Bundle.main.url(forResource: "sampleepisode", withExtension: "json")!
        )
        episode = try! decoder.decode(Episode.self, from: episodeData)
    }

    func getQuoteData(for show: String) async {
        fetchStatus = .fetching

        do {
            quote = try await fetcher.fetchQuote(from: show)

            character = try await fetcher.fetchCharacter(quote.character)

            character.death = try await fetcher.fetchDeath(for: character.name)

            fetchStatus = .successQuote
        } catch {
            fetchStatus = .faild(error: error)
        }
    }

    func getEpisodeData(for show: String) async {
        fetchStatus = .fetching

        do {
            if let unwrappedEpisode = try await fetcher.fetchEpisode(from: show) {
                episode = unwrappedEpisode
            }

            fetchStatus = .successEpisode
        } catch {
            fetchStatus = .faild(error: error)
        }
    }
}
