//
//  PokemonDemoApp.swift
//  PokemonDemo
//
//  Created by sanaz on 10/12/25.
//

import SwiftUI

@main
struct PokeDexDemoApp: App {
    @StateObject private var coordinator = AppCoordinator()
    @StateObject private var container = DIContainers(service: PokemonService())
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(coordinator)
                .environmentObject(container)
        }
    }
}
