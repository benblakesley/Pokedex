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
        
        ZStack
        {
            if pokemon.types.count > 1
            {
                let color1 = pokeColors[pokemon.types[0].type.name]
                let color2 = pokeColors[pokemon.types[1].type.name]
                
                LinearGradient(gradient: Gradient(colors: [color1!, color2!]),
                               startPoint: .top,
                               endPoint: .bottom).opacity(0.5)
            }
            else if pokemon.types.count == 1
            {
                pokeColors[pokemon.types[0].type.name]
                    .opacity(0.5)
            }
            
            VStack
            {
     
                Text("#\(pokemon.id) \(pokemon.name.capitalized)")
                    .font(.title)
                    .fontWeight(.heavy)
                    .foregroundColor(.white)

                HStack
                {
                    if pokemon.types.indices.contains(0)
                    {
                        PokemonTypeTextView(pokemonType: pokemon.types[0])
                    }
                    if pokemon.types.indices.contains(1)
                    {
                        PokemonTypeTextView(pokemonType: pokemon.types[1])
                    }
                }
                
                AsyncImage(url: URL(string: pokemon.sprites.frontDefault ?? "")) { phase in
                    switch phase {
                    case .empty:
                        Color.clear // Placeholder while loading
                    case .success(let image):
                        image
                            .resizable()
                            .scaledToFill()
                            .frame(width: 300, height: 300)
                            .clipped()
                    case .failure:
                        Color.clear
                    @unknown default:
                        Color.clear
                    }
                }
                
                StatsChartView(stats: pokemon.stats)
            }
        }
        .ignoresSafeArea()
    }
}

//#Preview {
//    PokemonSheetView(pokeViewModel: PokemonViewModel(), pokeIndex: 47)
//}
