//
//  PokemonTypeTextView.swift
//  Pokedex
//
//  Created by Ben Blakesley on 14/10/2024.
//

import SwiftUI

struct PokemonTypeTextView: View {
    
    var pokemonType: PokeType
    
    var body: some View {
        Text(pokemonType.type.name.capitalized)
            .frame(width: 80)
            .foregroundColor(.white)
            .background(pokeColors[pokemonType.type.name])
            .cornerRadius(10)
            .shadow(color: Color.black.opacity(0.3), radius: 4, x: 0, y: 2)
    }
}

//#Preview {
//    PokemonTypeTextView()
//}
