//
//  SearchViewModel.swift
//  Pokedex
//
//  Created by Ben Blakesley on 13/10/2024.
//

import Foundation

class SearchViewModel: ObservableObject
{
    @Published var searchText = ""
    
    public func searchedPokemon(pokemonList: [PokemonModel]) -> [PokemonModel]
    {
        if searchText.isEmpty
        {
            return pokemonList
        }
        else
        {
            return pokemonList.filter { pokemon in
                pokemon.name.lowercased().contains(searchText.lowercased())
            }
        }
    }
}
