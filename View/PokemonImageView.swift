//
//  PokemonImageView.swift
//  PokemonDemo
//
//  Created by sanaz on 10/12/25.
//

import Kingfisher
import SwiftUI

struct PokemonImageView: View {
    let pokemon: Pokemon
    let height: CGFloat
    
    var body: some View {
        KFImage(PokemonImageHelper.imageURL(for: pokemon))
            .placeholder {
                Image(systemName: "photo")
                    .resizable()
                    .scaledToFit()
                    .frame(height: height)
                    .foregroundColor(.gray)
            }
            .resizable()
            .scaledToFit()
            .frame(height: height)
    }
}

#Preview {
    PokemonImageView(
        pokemon: Pokemon(
            name: "Bulbasaur",
            url: URL(string: "https://pokeapi.co/api/v2/pokemon/1/")!
        ),
        height: 150
    )
}
