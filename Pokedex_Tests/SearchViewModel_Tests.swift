//
//  SearchViewModel_Tests.swift
//  Pokedex_Tests
//
//  Created by Ben Blakesley on 20/10/2024.
//

import XCTest
@testable import Pokedex

final class SearchViewModel_Tests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    private func createMockPokemonList() -> [PokemonModel]
    {
        var pokeList: [PokemonModel] = []
        for x in 1..<Int.random(in: 50...100)
        {
            let name: String = UUID().uuidString;
            pokeList.append(PokemonModel(name: name, id: x, sprites: PokeSprites(), types: [], stats: []))
        }
                
        return pokeList
    }
    
    func test_SearchViewModel_initialSearchText_isEmptyString()
    {
        // no set up needed
        
        let vm = SearchViewModel()
        
        XCTAssertEqual(vm.searchText, "")
    }
    
    func test_SearchViewModel_emptySearchTest_returnsSame()
    {
        //set up array of pokemon
        let pokeList: [PokemonModel] = createMockPokemonList()

        //set up search view model and set search text to empty string
        let vm = SearchViewModel()
        
        vm.searchText = ""
        
        let filteredPokeList = vm.searchedPokemon(pokemonList: pokeList)
        
        //Assertions
        XCTAssertEqual(filteredPokeList.count, pokeList.count)
        for i in 0..<pokeList.count
        {
            XCTAssertEqual(filteredPokeList[i].id, pokeList[i].id)
            XCTAssertEqual(filteredPokeList[i].name, pokeList[i].name)
        }
    }
    
    func test_SearchViewModel_noMatches_returnsEmptyArray()
    {
        //set up array of pokemon
        let pokeList: [PokemonModel] = createMockPokemonList()

        //set up search view model and set search text to dummy string
        let vm = SearchViewModel()
        
        // dummy search text
        vm.searchText = "there is no pokemon with this name"
        
        //assertions
        XCTAssertEqual(vm.searchedPokemon(pokemonList: pokeList).count, 0)
    }
    
    func test_SearchViewModel_match_returnsMatch()
    {
        //set up array of pokemon
        let pokeList: [PokemonModel] = createMockPokemonList()
        
        // get a random pokemon from this list, get its name and generate a random substring from its name
        let pokeListCount = pokeList.count

        //Generate a random pokemon
        let randomIndex = Int.random(in: 0..<pokeListCount)
        
        let randomPokemon = pokeList[randomIndex]
        
        let randomPokemonName = randomPokemon.name
        
        let randomPokemonNameLength = randomPokemonName.count
        
        // From the random pokemon generate a random substring from its name
        let randomSubstringStartingIndex = Int.random(in: 0...randomPokemonNameLength)
        
        let maxLength = randomPokemonNameLength - randomSubstringStartingIndex
        
        let desiredSubstringLength = Int.random(in: 1...maxLength)
        
        let start = randomPokemonName.index(randomPokemonName.startIndex, offsetBy: randomSubstringStartingIndex)
        let end = randomPokemonName.index(start, offsetBy: desiredSubstringLength)
        
        let nameSubstring = String(randomPokemonName[start..<end])
        
        //Set up viewmodel
        let vm = SearchViewModel()
        
        vm.searchText = nameSubstring
        
        let searchResults: [PokemonModel] = vm.searchedPokemon(pokemonList: pokeList)
        //assertions
        // need to check that the obtained search results match AND none were missed
        searchResults.forEach { pokemon in
            let name = pokemon.name
            XCTAssertTrue(name.contains(vm.searchText))
        }
        
        let nonSearchedResults = pokeList.filter { pokemon in
                !pokemon.name.contains(vm.searchText)
        }
        
        //check all non
        nonSearchedResults.forEach { pokemon in
            let name = pokemon.name
            XCTAssertFalse(name.contains(vm.searchText))
        }
        
        //Sanity checks
        XCTAssertEqual(pokeList.count, searchResults.count + nonSearchedResults.count)
        XCTAssertTrue(searchResults.count > 0)
        XCTAssertTrue(nonSearchedResults.count < pokeList.count)
    }
}
