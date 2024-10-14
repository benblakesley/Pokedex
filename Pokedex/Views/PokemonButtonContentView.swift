//
//  PokemonView.swift
//  Pokedex
//
//  Created by Ben Blakesley on 08/10/2024.
//

import SwiftUI

struct PokemonButtonContentView: View {
        
    var pokemon: PokemonModel
        
    var body: some View {
        ZStack
        {
            if pokemon.types.count > 1
            {
                let color1 = pokeColors[pokemon.types[0].type.name]
                let color2 = pokeColors[pokemon.types[1].type.name]
                
                LinearGradient(gradient: Gradient(colors: [color1!, color2!]),
                               startPoint: .leading,
                               endPoint: .trailing).opacity(0.8)
            }
            else if pokemon.types.count == 1
            {
                pokeColors[pokemon.types[0].type.name]
                    .opacity(0.8)
            }
            
            HStack
            {
                AsyncImage(url: URL(string: pokemon.sprites.frontDefault ?? "")) { phase in
                    switch phase {
                    case .empty:
                        Color.clear // Placeholder while loading
                    case .success(let image):
                        image
                            .resizable()
                            .scaledToFill()
                            .frame(width: 100, height: 100)
                            .clipped()
                    case .failure:
                        Color.clear
                    @unknown default:
                        Color.clear
                    }
                }
                
                VStack
                {
                    HStack
                    {
                        Text(pokemon.name.capitalized)
                            .font(.title3)
                            .fontWeight(.bold)
                            .foregroundColor(.white)
                        
                        Spacer()
                    }
                    
                    HStack
                    {
                        Text("#\(pokemon.id)")
                            .font(.title)
                            .fontWeight(.semibold)
                            .foregroundColor(.gray)
                        
                        Spacer()
                    }
                }
                
                Spacer()
                
                VStack
                {
                    if pokemon.types.indices.contains(0)
                    {
                        PokemonTypeTextView(pokemonType: pokemon.types[0])
                    }
                    if pokemon.types.indices.contains(1)
                    {
                        PokemonTypeTextView(pokemonType: pokemon.types[1])
                            .padding(EdgeInsets(top: 1, leading: 0, bottom: 0, trailing: 0))
                    }
                }
            }.padding()
        }
        .frame(height: 100)
        .cornerRadius(20)
        .padding(EdgeInsets(top: 0, leading: 10, bottom: 0, trailing: 10))
    }
}
//
//#Preview {
//    PokemonButtonContentView(pokeViewModel: PokemonModel(), pokeIndex: 1)
//}
