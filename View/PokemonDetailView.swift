//
//  PokemonDetailView.swift
//  PokemonDemo
//
//  Created by sanaz on 10/12/25.
//

import SwiftUI

struct PokemonDetailView: View {
    @ObservedObject private var viewModel: PokemonDetailViewModel
    let onFavorite: (Pokemon) -> Void
    
    init(viewModel: PokemonDetailViewModel, onFavorite: @escaping (Pokemon) -> Void) {
        self.viewModel = viewModel
        self.onFavorite = onFavorite
    }
    
    var body: some View {
        ScrollView {
            VStack(spacing: 4) {
                PokemonImageView(pokemon: viewModel.pokemon, height: 100)
                Text(viewModel.name)
                    .font(.largeTitle)
                    .bold()
                    .padding(.bottom, 8)
            }
            .padding(.horizontal)
            VStack(alignment: .leading, spacing: 8) {
                descriptionView()
            }
            .padding(.horizontal, 16)
            .padding(.bottom, 24)
            .task {
                await viewModel.fetchDescription()
            }
        }
        .toolbar {
            ToolbarItem(placement: .topBarTrailing) {
                Button {
                    Task {
                        await viewModel.toggleFavorite()
                        onFavorite(viewModel.pokemon)
                    }
                } label: {
                    Image(systemName: viewModel.isFavorite ? "heart.fill" : "heart")
                        .foregroundStyle(viewModel.isFavorite ? .red : .primary)
                }
            }
        }
    }
    
    @ViewBuilder
    private func descriptionView() -> some View {
        if viewModel.isLoading {
            ProgressView("Loading description...")
                .italic()
                .foregroundColor(.gray)
        } else {
            ForEach(Array(viewModel.descriptions.enumerated()), id: \.offset) { _, description in
                Text(description)
                    .font(.body)
                    .multilineTextAlignment(.leading)
            }
        }
    }
}

#Preview {
    PokemonDetailView(viewModel: PokemonDetailViewModel(pokemon: Pokemon(
        name: "Bulbasaur",
        url: URL(string: "https://pokeapi.co/api/v2/pokemon/1/")!
    ), service: MockService()), onFavorite: { _ in })
}
