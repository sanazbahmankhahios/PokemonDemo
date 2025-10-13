//
//  NetworkError.swift
//  PokemonDemo
//
//  Created by sanaz on 10/12/25.
//

import Foundation

enum NetworkError: Error, LocalizedError {
    case invalidURL
    case requestFailed
    case badResponse
    case decodingError
    case encodingError
    
    var errorDescription: String? {
        switch self {
        case .invalidURL:
            "The URL is invalid."
        case .requestFailed:
            "Network request failed"
        case .badResponse:
            "Received an unsuccessful response from the server."
        case .decodingError:
            "Failed to decode the response."
        case .encodingError:
            "Failed to encode the response."
        }
    }
}
