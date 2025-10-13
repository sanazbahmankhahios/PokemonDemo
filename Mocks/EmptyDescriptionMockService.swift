//
//  EmptyDescriptionMockService.swift
//  PokemonDemo
//
//  Created by sanaz on 10/12/25.
//

import Foundation

class EmptyDescriptionMockService: PokemonServiceProtocol {
    func favorite(pokemon _: Pokemon) async throws {
        throw NetworkError.requestFailed
    }
    
    func fetchPokemonList(limit _: Int, offset _: Int) async throws -> [Pokemon] {
        [Pokemon(name: "Ditto", url: URL(string: "https://pokeapi.co/api/v2/pokemon/132/")!)]
    }
    
    func fetchPokemonDescription(for _: Pokemon) async throws -> [String] {
        []
    }
}
