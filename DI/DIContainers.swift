//
//  DIContainers.swift
//  PokemonDemo
//
//  Created by sanaz on 10/12/25.
//

import Foundation
import Combine

@MainActor
final class DIContainers: ObservableObject {
    let service: PokemonServiceProtocol
    
    init(service: PokemonServiceProtocol) {
            self.service = service
        }
    
    func makeListViewModel() -> PokemonListViewModel {
        PokemonListViewModel(service: service)
    }
}
