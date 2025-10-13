//
//  MockService.swift
//  PokemonDemo
//
//  Created by sanaz on 10/12/25.
//

import Foundation

class MockService: PokemonServiceProtocol {
    var shouldFavoriteSucceed = true
    
    func fetchPokemonList(limit _: Int, offset _: Int) async throws -> [Pokemon] {
        [
            Pokemon(name: "Bulbasaur", url: URL(string: "https://pokeapi.co/api/v2/pokemon/1/")!),
            Pokemon(name: "Charmander", url: URL(string: "https://pokeapi.co/api/v2/pokemon/4/")!),
            Pokemon(name: "Squirtle", url: URL(string: "https://pokeapi.co/api/v2/pokemon/7/")!),
            Pokemon(name: "Pikachu", url: URL(string: "https://pokeapi.co/api/v2/pokemon/25/")!),
            Pokemon(name: "Jigglypuff", url: URL(string: "https://pokeapi.co/api/v2/pokemon/39/")!),
            Pokemon(name: "Meowth", url: URL(string: "https://pokeapi.co/api/v2/pokemon/52/")!)
        ]
    }
    
    func fetchPokemonDescription(for pokemon: Pokemon) async throws -> [String] {
        [
            "\(pokemon.name.capitalized) is a starter Pokémon!",
            "\(pokemon.name.capitalized) can evolve!",
            "\(pokemon.name.capitalized) has unique abilities!",
            "\(pokemon.name.capitalized) is popular in battles!",
            "\(pokemon.name.capitalized) is from Kanto region!",
            "\(pokemon.name.capitalized) is loved by fans!",
        ]
    }
    
    func favorite(pokemon _: Pokemon) async throws {
        if !shouldFavoriteSucceed {
            throw NetworkError.requestFailed
        }
    }
}
