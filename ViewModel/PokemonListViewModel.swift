//
//  PokemonListViewModel.swift
//  PokemonDemo
//
//  Created by sanaz on 10/12/25.
//

import Foundation
import SwiftUI

@MainActor
class PokemonListViewModel: ObservableObject {
    @Published var pokemons: [Pokemon] = []
    @Published var isLoading = false
    @Published var errorMessage: String?
    @Published var descriptions: [String] = []
    
    private let limit = 21
    private let service: PokemonServiceProtocol
    
    init(service: PokemonServiceProtocol) {
        self.service = service
    }
    
    func update(pokemon: Pokemon) {
        guard let index = pokemons.firstIndex(where: { $0.id == pokemon.id }) else { return }
        pokemons[index] = pokemon
    }
    
    func loadPokemons() async {
        isLoading = true
        defer { isLoading = false }
        guard pokemons.isEmpty else { return }
        do {
            pokemons = try await service.fetchPokemonList(limit: limit, offset: 0)
        } catch {
            errorMessage = error.localizedDescription
        }
    }
    
    func loadMorePokemons(item: Pokemon) async {
        guard isLoading == false else { return }
        guard let index = pokemons.firstIndex(where: { $0.id == item.id }),
              index + 1 == pokemons.count
        else {
            return
        }
        isLoading = true
        defer { isLoading = false }
        
        do {
            let newItems = try await service.fetchPokemonList(limit: limit, offset: index + 1)
            withAnimation(.easeInOut) {
                pokemons.append(contentsOf: newItems)
            }
        } catch {
            errorMessage = error.localizedDescription
        }
    }
}
