//
//  PokemonCellView.swift
//  PokemonDemo
//
//  Created by sanaz on 10/12/25.
//

import SwiftUI

struct PokemonCellView: View {
    private let imageHeight: CGFloat = 100
    let pokemon: Pokemon
    var onTap: (() -> Void)? = nil
    
    var body: some View {
        VStack {
            PokemonImageView(pokemon: pokemon, height: imageHeight)
            Text(pokemon.name.capitalized)
                .dynamicTypeSize(.medium)

        }
        .padding(8)
        .background(Color(.secondarySystemBackground))
        .cornerRadius(12)
        .shadow(radius: 2)
        .frame(maxWidth: .infinity)
        .contentShape(Rectangle())
        .onTapGesture { onTap?()
        }
    }
}

#Preview(traits: .sizeThatFitsLayout) {
    PokemonCellView(
        pokemon: Pokemon(
            name: "Bulbasaur",
            url: URL(string: "https://pokeapi.co/api/v2/pokemon/1/")!
        )
    )
}
