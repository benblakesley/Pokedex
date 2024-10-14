//
//  PokedexView.swift
//  Pokedex
//
//  Created by Ben Blakesley on 08/10/2024.
//

import SwiftUI

struct PokedexView: View {
        
    @EnvironmentObject var pokeViewModel: PokemonViewModel
    
    @StateObject var searchViewModel = SearchViewModel()
    
    var body: some View {
        
        SearchBarView(searchText: $searchViewModel.searchText)

        ScrollView
        {
            if(pokeViewModel.pokemon.count == 151)
            {
                let pokeList = searchViewModel.searchedPokemon(pokemonList: pokeViewModel.pokemon)
                
                VStack
                {
                    if pokeList.count > 0
                    {
                        ForEach(pokeList) {pokemon in
                            PokemonButtonView(pokemon: pokemon)
                        }
                    }
                    else
                    {
                        SearchErrorView(psyduck: pokeViewModel.pokemon[53])
                    }
                }
            }
            else
            {
                ProgressView()
            }
        }
        .onAppear
        {
            pokeViewModel.generatePokemon()
        }
    }
}

#Preview {
    PokedexView()
        .environmentObject(PokemonViewModel())
}
