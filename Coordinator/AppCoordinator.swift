//
//  AppCoordinator.swift
//  PokemonDemo
//
//  Created by sanaz on 10/12/25.
//

import Foundation
import SwiftUI

@MainActor
final class AppCoordinator: ObservableObject {
    @Published var path = NavigationPath()
    
    func showDetail(for pokemon: Pokemon) {
        path.append(pokemon)
    }
    
    func pop() {
        path.removeLast()
    }
}
