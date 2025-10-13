//
//  PokemonDemoTests.swift
//  PokemonDemoTests
//
//  Created by sanaz on 10/12/25.
//

@testable import PokemonDemo
import XCTest

@MainActor
final class PokeDexDemoTests: XCTestCase {
    var viewModel: PokemonListViewModel!
    var container: DIContainers!
    var mockService: MockService!
    
    var makeListViewModel = PokemonListViewModel(service: MockService() as PokemonServiceProtocol)
    
    override func setUp() async throws {
        mockService = MockService()
        container = DIContainers(service: mockService)
        viewModel = container.makeListViewModel()
    }
    
    override func tearDown() {
        viewModel = nil
        mockService = nil
        container = nil
        super.tearDown()
    }
    
    func testPokemonID() {
        let bulbasaur = Pokemon(name: "Bulbasaur", url: URL(string: "https://pokeapi.co/api/v2/pokemon/1/")!)
        XCTAssertEqual(bulbasaur.id, 1)
        let charmander = Pokemon(name: "Charmander", url: URL(string: "https://pokeapi.co/api/v2/pokemon/4/")!)
        XCTAssertEqual(charmander.id, 4)
        let unknown = Pokemon(name: "Unknown", url: URL(string: "https://pokeapi.co/api/v2/pokemon/")!)
        XCTAssertEqual(unknown.id, 0)
    }
    
    func testLoadPokemons() async throws {
        await viewModel.loadPokemons()
        
        XCTAssertEqual(viewModel.pokemons.count, 6)
        XCTAssertEqual(viewModel.pokemons.first?.name, "Bulbasaur")
        XCTAssertFalse(viewModel.isLoading)
        XCTAssertNil(viewModel.errorMessage)
    }
    
    func testLoadPokemonsFailure() async throws {
        let failingContainer = DIContainers(service: FailingMockService())
        let failingViewModel = failingContainer.makeListViewModel()
        await failingViewModel.loadPokemons()
        
        XCTAssertEqual(failingViewModel.pokemons.count, 0)
        XCTAssertEqual(failingViewModel.errorMessage, NetworkError.requestFailed.localizedDescription)
    }
    
    func testFetchDescriptions() async throws {
        let pokemon = Pokemon(name: "Bulbasaur", url: URL(string: "https://pokeapi.co/api/v2/pokemon/1/")!)
        let viewModel = PokemonDetailViewModel(pokemon: pokemon, service: container.service)
        await viewModel.fetchDescription()
        
        XCTAssertEqual(viewModel.descriptions.count, 6)
        XCTAssertTrue(viewModel.descriptions.contains { $0.contains("Bulbasaur is a starter Pokémon!") })
    }
    
    func testFetchDescriptionEmpty() async throws {
        let emptyContainer = DIContainers(service: EmptyDescriptionMockService())
        let pokemon = Pokemon(name: "Ditto", url: URL(string: "https://pokeapi.co/api/v2/pokemon/132/")!)
        let viewModel = PokemonDetailViewModel(pokemon: pokemon, service: emptyContainer.service)
        
        await viewModel.fetchDescription()
        
        XCTAssertEqual(viewModel.descriptions, ["No description available"])
    }
    
    func testFavoritePokemon_Failure() async {
        mockService.shouldFavoriteSucceed = false
        let pokemon = Pokemon(name: "Pikachu", url: URL(string: "https://pokeapi.co/api/v2/pokemon/25/")!)
        
        do {
            _ = try await container.service.favorite(pokemon: pokemon)
            XCTFail("Expected NetworkError.requestFailed but got success")
        } catch {
            XCTAssertTrue(error is NetworkError, "Expected NetworkError but got \(error)")
        }
    }
    
    func testCleanDescription() {
        let service = PokemonService()
        let rawText = "\nBulbasaur is a starter Pokémon!\u{0C}  "
        let cleaned = service.cleanDescription(rawText)
        
        XCTAssertEqual(cleaned, "Bulbasaur is a starter Pokémon!")
        let whitespaceText = "   \n\u{0C}  "
        XCTAssertEqual(service.cleanDescription(whitespaceText), "")
        let normalText = "Pikachu"
        XCTAssertEqual(service.cleanDescription(normalText), "Pikachu")
    }
}
