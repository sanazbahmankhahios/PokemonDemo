//
//  PokemonImageHelper.swift
//  PokemonDemo
//
//  Created by sanaz on 10/12/25.
//

import Foundation

struct PokemonImageHelper {
    static func imageURL(for pokemon: Pokemon) -> URL? {
       URL(string: "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/\(pokemon.id).png")
    }
}
