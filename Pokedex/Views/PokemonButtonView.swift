//
//  PokemonButtonView.swift
//  Pokedex
//
//  Created by Ben Blakesley on 11/10/2024.
//

import SwiftUI

struct PokemonButtonView: View {
    
    var pokemon: PokemonModel
    
    @State var isSheetVisible = false

    var body: some View {
        Button(
            action: {
                isSheetVisible.toggle()
        },
            label: {PokemonButtonContentView(pokemon: pokemon)}
        )
        .sheet(isPresented: $isSheetVisible,
               content: {
            PokemonSheetView(pokemon: pokemon)
        })
    }
}
