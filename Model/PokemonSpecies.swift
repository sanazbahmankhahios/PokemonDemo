//
//  PokemonSpecies.swift
//  PokemonDemo
//
//  Created by sanaz on 10/12/25.
//

import Foundation

struct PokemonSpecies: Codable {
    struct FlavorTextEntry: Codable {
        let flavor_text: String
        let language: Language
        struct Language: Codable { let name: String }
    }
    
    let flavor_text_entries: [FlavorTextEntry]
}
