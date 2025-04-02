//
//  ContentView.swift
//  Dex
//
//  Created by Victor Emanuel Ribeiro Silva on 27/03/25.
//

import CoreData
import SwiftUI

struct ContentView: View {
    @Environment(\.managedObjectContext) private var viewContext

    @FetchRequest<Pokemon>(
        sortDescriptors: [],
        animation: .default
    ) private var all: FetchedResults<Pokemon>

    @FetchRequest<Pokemon>(
        sortDescriptors: [SortDescriptor(\.id)],
        animation: .default
    ) private var pokedex: FetchedResults<Pokemon>

    let fetcher = FetchService()

    @State var searchText: String = ""
    @State var filterByFavorite = false

    private var dynamicPredicate: NSPredicate {
        var predicates: [NSPredicate] = []

        // Search predicate
        if !searchText.isEmpty {
            predicates.append(NSPredicate(format: "name contains[c] %@", searchText))
        }

        // Filter by favorite predicate
        if filterByFavorite {
            predicates.append(NSPredicate(format: "favorite == %d", true))
        }

        // Combine predicates
        return NSCompoundPredicate(andPredicateWithSubpredicates: predicates)
    }

    var body: some View {
        if all.isEmpty {
            ContentUnavailableView {
                Label("No Pokemon", image: .nopokemon)
            } description: {
                Text("There aren't any Pokemon yet.\nFetch some Pokemon to get started!")
            } actions: {
                Button("Fetch Pokemon", systemImage: "antenna.radiowaves.left.and.right") {
                    getPokemon(from: 1)
                }
            }.buttonStyle(.borderedProminent)

        } else {
            NavigationStack {
                List {
                    Section {
                        ForEach(pokedex) { pokemon in
                            NavigationLink(value: pokemon) {
                                if pokemon.sprite == nil {
                                    AsyncImage(url: pokemon.sprite) {
                                        image in image.resizable().scaledToFit()
                                    } placeholder: {
                                        ProgressView()
                                    }.frame(width: 100, height: 100)
                                } else {
                                    pokemon.spriteImage
                                        .resizable()
                                        .scaledToFit()
                                        .frame(width: 100, height: 100)
                                }

                                VStack(alignment: .leading) {
                                    HStack {
                                        Text(pokemon.name!.capitalized).fontWeight(.bold)

                                        if pokemon.favorite {
                                            Image(systemName: "star.fill")
                                                .foregroundColor(.yellow)
                                        }
                                    }

                                    HStack {
                                        ForEach(pokemon.types!, id: \.self) { type in
                                            Text(type.capitalized).font(.subheadline)
                                                .fontWeight(.semibold)
                                                .foregroundStyle(.black)
                                                .padding(.horizontal, 13)
                                                .padding(.vertical, 5)
                                                .background(Color(type.capitalized))
                                                .clipShape(.capsule)
                                        }
                                    }
                                }
                            }
                            .swipeActions(edge: .leading) {
                                Button(pokemon.favorite ? "Remove from Favorites" : "Add to Favorites", systemImage: pokemon.favorite ? "trash" : "star") {
                                    pokemon.favorite.toggle()

                                    do {
                                        try viewContext.save()
                                    } catch {
                                        print(error)
                                    }
                                }
                            }.tint(pokemon.favorite ?.gray : .yellow)
                        }
                    } footer: {
                        if all.count < 151 {
                            ContentUnavailableView {
                                Label("Missing Pokemon", image: .nopokemon)
                            } description: {
                                Text("The fetch was interrupted!\nFetch the rest of the Pokemon.")
                            } actions: {
                                Button("Fetch Pokemon", systemImage: "antenna.radiowaves.left.and.right") {
                                    getPokemon(from: pokedex.count + 1)
                                }
                                .buttonStyle(.borderedProminent)
                            }
                        }
                    }
                }
                .navigationTitle("Pokedex")
                .searchable(text: $searchText, prompt: "Find a Pokemon")
                .autocorrectionDisabled()
                .onChange(of: searchText) {
                    pokedex.nsPredicate = dynamicPredicate
                }
                .onChange(of: filterByFavorite) {
                    pokedex.nsPredicate = dynamicPredicate
                }
                .navigationDestination(for: Pokemon.self, destination: { pokemon in

                    PokemonDetail()
                        .environmentObject(pokemon)

                })
                .toolbar {
                    ToolbarItem(placement: .navigationBarTrailing) {
                        Button {
                            filterByFavorite.toggle()
                        } label: {
                            Label(
                                "Filter By Favorites",
                                systemImage: filterByFavorite ? "star.fill" : "star"
                            )
                        }.tint(.yellow)
                    }
                }
            }
        }
    }

    private func getPokemon(from id: Int) {
        Task {
            for i in id ..< 152 {
                do {
                    let fetchedPokemon = try await fetcher.fetchPokemon(i)

                    let pokemon = Pokemon(context: viewContext)
                    pokemon.id = fetchedPokemon.id
                    pokemon.name = fetchedPokemon.name
                    pokemon.types = fetchedPokemon.types
                    pokemon.hp = fetchedPokemon.hp
                    pokemon.attack = fetchedPokemon.attack
                    pokemon.defense = fetchedPokemon.defense
                    pokemon.specialAttack = fetchedPokemon.specialAttack
                    pokemon.specialDefense = fetchedPokemon.specialDefense
                    pokemon.speed = fetchedPokemon.speed
                    pokemon.spriteURL = fetchedPokemon.spriteURL
                    pokemon.shinyURL = fetchedPokemon.shinyURL

                    try viewContext.save()

                } catch {
                    print(error)
                }
            }

            storeSprites()
        }
    }

    private func storeSprites() {
        Task {
            do {
                for pokemon in all {
                    pokemon.sprite = try await URLSession.shared
                        .data(from: pokemon.spriteURL!).0

                    pokemon.shiny = try await URLSession.shared
                        .data(from: pokemon.shinyURL!).0
                }
            } catch {
                print(error)
            }
        }
    }
}

#Preview {
    ContentView().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
}
