//
//  PokemonGridView.swift
//  PokemonDemo
//
//  Created by sanaz on 10/12/25.
//

import SwiftUI

struct PokemonGridView: View {
    var isLoading: Bool = false
    let pokemons: [Pokemon]
    let onSelectPokemon: (Pokemon) -> Void
    let onAppearPokemon: (Pokemon) -> Void
    
    let columns = [GridItem(.adaptive(minimum: 110), spacing: 16)]
    
    var body: some View {
        LazyVGrid(columns: columns, spacing: 16) {
            ForEach(pokemons) { pokemon in
                PokemonCellView(pokemon: pokemon) {
                    onSelectPokemon(pokemon)
                }
                .onAppear {
                    onAppearPokemon(pokemon)
                }
            }
            loadingView()
        }
    }
    
    @ViewBuilder
    private func loadingView() -> some View {
        if isLoading {
            ProgressView()
                .frame(maxWidth: .infinity)
                .padding(.vertical)
        }
    }
}

#Preview {
    PokemonGridView(
        pokemons: [
            Pokemon(name: "Bulbasaur", url: URL(string: "https://pokeapi.co/api/v2/pokemon/1/")!),
            Pokemon(name: "Charmander", url: URL(string: "https://pokeapi.co/api/v2/pokemon/4/")!),
            Pokemon(name: "Squirtle", url: URL(string: "https://pokeapi.co/api/v2/pokemon/7/")!)
        ],
        onSelectPokemon: { pokemon in
            print("Tapped on \(pokemon.name)")
        },
        onAppearPokemon: { _ in
            
        }
    )
}
