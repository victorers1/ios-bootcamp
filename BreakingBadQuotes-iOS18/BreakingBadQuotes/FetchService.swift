//
//  FetchService.swift
//  BreakingBadQuotes
//
//  Created by Victor Emanuel Ribeiro Silva on 21/03/25.
//

import Foundation

struct FetchService {
    private enum FetchError: Error {
        case badResponse
    }

    private let baseURL = URL(string: "https://breaking-bad-api-six.vercel.app/api")!

    func fetchQuote(from show: String) async throws -> Quote {
        // Build fetch url
        let fetchURL = baseURL
            .appendingPathComponent("quotes/random")
            .appending(queryItems: [URLQueryItem(name: "production", value: show)])

        // Fetch data
        let (data, response) = try await URLSession.shared.data(from: fetchURL)

        // Handle response
        guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
            throw FetchError.badResponse
        }

        // Decode data
        let quote = try JSONDecoder().decode(Quote.self, from: data)

        // Return quote
        return quote
    }

    func fetchCharacter(_ name: String) async throws -> Char {
        // Build fetch url
        let fetchURL = baseURL
            .appendingPathComponent("characters")
            .appending(queryItems: [URLQueryItem(name: "name", value: name)])

        // Fetch data
        let (data, response) = try await URLSession.shared.data(from: fetchURL)

        // Handle response
        guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
            throw FetchError.badResponse
        }

        // Decode data
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase

        let characters = try decoder.decode([Char].self, from: data)

        // Return quote
        return characters[0]
    }

    func fetchDeath(for character: String) async throws -> Death? {
        let fetchURL = baseURL.appending(path: "deaths")

        let (data, response) = try await URLSession.shared.data(from: fetchURL)

        guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
            throw FetchError.badResponse
        }

        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase

        let deaths = try decoder.decode([Death].self, from: data)

        for death in deaths {
            if death.character == character {
                return death
            }
        }

        return nil
    }

    func fetchEpisode(from show: String) async throws -> Episode? {
        let fetchURL = baseURL
            .appendingPathComponent("episodes")
            .appending(queryItems: [URLQueryItem(name: "production", value: show)])

        let (data, response) = try await URLSession.shared.data(from: fetchURL)

        guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
            throw FetchError.badResponse
        }

        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase

        let episodes = try decoder.decode([Episode].self, from: data)

        // Return quote
        return episodes.randomElement()
    }
}
