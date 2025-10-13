//
//  ContentView.swift
//  PokemonDemo
//
//  Created by sanaz on 10/12/25.
//

import SwiftUI

struct ContentView: View {
    @EnvironmentObject var container: DIContainers
    @EnvironmentObject var coordinator: AppCoordinator
    @State var listViewModel: PokemonListViewModel? = nil
    
    var body: some View {
        NavigationStack(path: $coordinator.path) {
            if let listViewModel {
                PokemonListView(viewModel: listViewModel) { selectedPokemon in
                    coordinator.showDetail(for: selectedPokemon)
                }
                .navigationDestination(for: Pokemon.self) { pokemon in
                    PokemonDetailView(viewModel: PokemonDetailViewModel(pokemon: pokemon,
                                                                        service: container.service))
                    { pokemon in
                        listViewModel.update(pokemon: pokemon)
                    }
                }
            } else {
                ProgressView("Loading Pokédex...")
            }
        }
        .dynamicTypeSize(.medium)
        .onAppear {
            if listViewModel == nil {
                listViewModel = container.makeListViewModel()
            }
        }
    }
}

#Preview {
    let mockContainer = DIContainers(service: MockService())
    let appCoordinator = AppCoordinator()
    ContentView()
        .environmentObject(mockContainer)
        .environmentObject(appCoordinator)
}
