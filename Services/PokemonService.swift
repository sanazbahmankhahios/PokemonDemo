//
//  PokemonService.swift
//  PokemonDemo
//
//  Created by sanaz on 10/12/25.
//

import Foundation

protocol PokemonServiceProtocol {
    func fetchPokemonList(limit: Int, offset: Int) async throws -> [Pokemon]
}

final class PokemonService: PokemonServiceProtocol {
    
    /// Source documentation: `https://pokeapi.co/api/v2/pokemon?limit=10&offset=0`
    func fetchPokemonList(limit: Int, offset: Int) async throws -> [Pokemon] {
        guard var components = URLComponents(string: "\(NetworkConstants.baseURL)pokemon") else {
            throw NetworkError.invalidURL
        }
        components.queryItems = [
            URLQueryItem(name: "limit", value: "\(limit)"),
            URLQueryItem(name: "offset", value: "\(offset)")
        ]
        guard let url = components.url else {
            throw NetworkError.invalidURL
        }
        
        do {
            let (data, response) = try await URLSession.shared.data(from: url)
            try validateHTTPResponse(response)
            
            let decoded = try JSONDecoder().decode(PokemonResponse.self, from: data)
            return decoded.results
        } catch is DecodingError {
            throw NetworkError.decodingError
        } catch {
            throw error
        }
    }
    
    private func validateHTTPResponse(_ response: URLResponse) throws {
        guard let httpResponse = response as? HTTPURLResponse,
              (200...299).contains(httpResponse.statusCode) else {
            throw NetworkError.badResponse
            
        }
    }
}
