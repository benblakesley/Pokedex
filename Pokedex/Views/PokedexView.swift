//
//  PokedexView.swift
//  Pokedex
//
//  Created by Ben Blakesley on 08/10/2024.
//

import SwiftUI

struct PokedexView: View {
    
    @StateObject var pokeViewModel = PokemonViewModel()
    
    @State var isPokeSelected = false
    
    @State private var selectedPokeIndex: Int?
        
    var body: some View {
        ScrollView
        {
            if(pokeViewModel.pokemon.count == 151)
            {
                VStack
                {
                    ForEach(0..<150) { index in
                        Button(action: {
                            selectedPokeIndex = index + 1
                            isPokeSelected.toggle()
                        },
                               label: {PokemonView(pokeViewModel: pokeViewModel, pokeId: index)})
                        .sheet(isPresented: $isPokeSelected, content: {
                            if let index = selectedPokeIndex
                            {
                                Text("\(index)")
                            }
                        })
                        
                    }
                }
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
}
