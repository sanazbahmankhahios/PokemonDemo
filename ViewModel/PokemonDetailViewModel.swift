//
//  PokemonDetailViewModel.swift
//  PokemonDemo
//
//  Created by sanaz on 10/12/25.
//

import Foundation

@MainActor
final class PokemonDetailViewModel: ObservableObject {
    @Published var descriptions: [String] = []
    @Published var name: String
    @Published var isLoading = false
    @Published var isFavorite = false
    private var isProcessing = false
    
    var pokemon: Pokemon
    private let service: PokemonServiceProtocol
    
    init(pokemon: Pokemon, service: PokemonServiceProtocol) {
        self.pokemon = pokemon
        name = pokemon.name.capitalized
        self.service = service
        self.isFavorite = pokemon.isFavorite
    }
    
    func fetchDescription() async {
        isLoading = true
        defer { isLoading = false }
        
        do {
            let descriptions = try await service.fetchPokemonDescription(for: pokemon)
            self.descriptions = descriptions.isEmpty ? ["No description available"] : descriptions
        } catch {
            self.descriptions = ["No description available"]
        }
    }
    
    func toggleFavorite() async {
        guard !isProcessing else { return }
           isProcessing = true
           defer { isProcessing = false }
            isFavorite.toggle()
        do {
            try await service.favorite(pokemon: pokemon)
            pokemon.isFavorite = isFavorite
        } catch {
            print("Failed to favorite Pokémon: \(error)")
        }
    }
}
