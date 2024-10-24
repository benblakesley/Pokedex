//
//  PokedexApp.swift
//  Pokedex
//
//  Created by Ben Blakesley on 08/10/2024.
//

import SwiftUI

@main
struct PokedexApp: App {
    
    var body: some Scene {
        
        WindowGroup {
            PokedexView(numberOfPokemon: 1008)
                .environmentObject(PokemonViewModel(pokemon: [], pokeService: PokeService(), manager: ImageCacheManager.instance, imageLoader: ImageLoader()))
                .environmentObject(SettingsViewModel())
        }
    }
}
