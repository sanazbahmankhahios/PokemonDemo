//
//  FailingMockService.swift
//  PokemonDemo
//
//  Created by sanaz on 10/12/25.
//

import Foundation

class FailingMockService: PokemonServiceProtocol {
    func favorite(pokemon _: Pokemon) async throws {
        throw NetworkError.requestFailed
    }
    
    func fetchPokemonList(limit _: Int, offset _: Int) async throws -> [Pokemon] {
        throw NetworkError.requestFailed
    }
    
    func fetchPokemonDescription(for _: Pokemon) async throws -> [String] {
        throw NetworkError.requestFailed
    }
}
