//
//  PokemonListView.swift
//  PokemonDemo
//
//  Created by sanaz on 10/12/25.
//

import SwiftUI

struct PokemonListView: View {
    @ObservedObject var viewModel: PokemonListViewModel
    let columns = [GridItem(.adaptive(minimum: 100), spacing: 16)]
    let onSelectPokemon: (Pokemon) -> Void
    
    init(viewModel: PokemonListViewModel, onSelectPokemon: @escaping (Pokemon) -> Void) {
        self.viewModel = viewModel
        self.onSelectPokemon = onSelectPokemon
    }
    
    var body: some View {
        ScrollView {
            PokemonGridView(
                pokemons: viewModel.pokemons,
                onSelectPokemon: onSelectPokemon,
                onAppearPokemon: { item in
                    if item.id == viewModel.pokemons.last?.id {
                        Task { await viewModel.loadMorePokemons(item: item) }
                    }
                }
            )
            .padding()
            statusOverlay()
        }
        .navigationTitle("Pokédex")
        .task {
            await viewModel.loadPokemons()
        }
    }
    
    private func statusOverlay() -> some View {
        VStack {
            if viewModel.isLoading {
                ProgressView()
                    .padding()
            }
            if let error = viewModel.errorMessage {
                Text(error)
                    .foregroundColor(.red)
                    .padding()
            }
        }
    }
}

#Preview(traits: .sizeThatFitsLayout) {
    PokemonListView(viewModel: PokemonListViewModel(service: MockService())) { _ in
    }
}
