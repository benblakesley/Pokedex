//
//  PokemonViewModel.swift
//  Pokedex
//
//  Created by Ben Blakesley on 08/10/2024.
//

import Foundation

class PokemonViewModel: ObservableObject
{
    @Published var pokemon: [PokemonModel] = []

    private let pokeService = PokeService()
    
    public func generatePokemon()
    {
        (1...151).forEach{(index) in
                self.pokeService.loadPokemon(index) { (result) in
                    
                    DispatchQueue.main.async {
                        switch result {
                        case .success(let pokemon):
                            self.pokemon.append(pokemon)
                            self.pokemon.sort{ $0.id < $1.id }
                        case .failure(let error):
                            print(error)
                        }
                    }
                }
            }}
     
    }
