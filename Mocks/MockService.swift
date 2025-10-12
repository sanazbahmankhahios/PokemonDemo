//
//  MockService.swift
//  PokemonDemo
//
//  Created by sanaz on 10/12/25.
//

import Foundation

class MockService: PokemonServiceProtocol {
    
    func fetchPokemonList(limit: Int, offset: Int) async throws -> [Pokemon] {
        return [
            Pokemon(name: "Bulbasaur", url: URL(string: "https://pokeapi.co/api/v2/pokemon/1/")!),
            Pokemon(name: "Charmander", url: URL(string: "https://pokeapi.co/api/v2/pokemon/4/")!),
            Pokemon(name: "Squirtle", url: URL(string: "https://pokeapi.co/api/v2/pokemon/7/")!),
            Pokemon(name: "Pikachu", url: URL(string: "https://pokeapi.co/api/v2/pokemon/25/")!),
            Pokemon(name: "Jigglypuff", url: URL(string: "https://pokeapi.co/api/v2/pokemon/39/")!),
            Pokemon(name: "Meowth", url: URL(string: "https://pokeapi.co/api/v2/pokemon/52/")!)
        ]
    }
}
