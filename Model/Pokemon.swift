//
//  Pokemon.swift
//  PokemonDemo
//
//  Created by sanaz on 10/12/25.
//

import Foundation

struct Pokemon: Codable, Identifiable, Hashable {
    let name: String
    let url: URL
    var isFavorite: Bool = false
    
    var id: Int {
        Int(url.pathComponents.last ?? "") ?? 0
    }
    
    enum CodingKeys: CodingKey {
        case name
        case url
    }
}

struct PokemonResponse: Codable {
    let results: [Pokemon]
}
