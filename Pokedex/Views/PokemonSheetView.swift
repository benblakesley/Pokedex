//
//  PokemonSheetView.swift
//  Pokedex
//
//  Created by Ben Blakesley on 11/10/2024.
//

import SwiftUI

struct PokemonSheetView: View {

    var pokemon: PokemonModel
    
    var body: some View {
        
        Text("\(pokemon.name.capitalized)")
            
            Text("\(pokemon.id)")
        }
}

//#Preview {
//    PokemonSheetView(pokeViewModel: PokemonViewModel(), pokeIndex: 47)
//}
