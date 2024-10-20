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
    
    @State var filterFavorites = false
    
    var body: some View {
        
        HStack
        {
            SearchBarView(searchText: $searchViewModel.searchText)
            
            Button {
                filterFavorites.toggle()
            } label: {
                Image(systemName: filterFavorites ? "heart.fill" : "heart")
                                .resizable()
                                .frame(width: 20, height: 20)
                                .foregroundColor(filterFavorites ? .red : .gray)
            }
            .padding(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 20))
        }
   

        ScrollView
        {
            if(pokeViewModel.pokemon.count > 0)
            {
                let pokeList = filterFavorites ?  searchViewModel.searchedPokemon(pokemonList: pokeViewModel.getFavorites(pokemom: pokeViewModel.pokemon)) : searchViewModel.searchedPokemon(pokemonList: pokeViewModel.pokemon)

                LazyVStack
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
