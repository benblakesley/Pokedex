//
//  PokemonView.swift
//  Pokedex
//
//  Created by Ben Blakesley on 08/10/2024.
//

import SwiftUI

struct PokemonButtonContentView: View {
    
    var pokemon: PokemonModel
    
    @State private var image: UIImage?
    
    @EnvironmentObject var pokeViewModel: PokemonViewModel
    
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
                if let image = self.image
                {
                    Image(uiImage: image)
                        .resizable()
                        .scaledToFill()
                        .frame(width: 100, height: 100)
                        .clipped()
                }
                else
                {
                    Color.clear
                        .frame(width: 100, height: 100)
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
                        
                        let isFavorited = pokeViewModel.isFavorited(pokemon: pokemon)
                        
                        Button {
                            pokeViewModel.toggleFavorite(for: pokemon)
                        } label: {
                            Image(systemName: isFavorited ? "heart.fill" : "heart")
                                .resizable()
                                .frame(width: 20, height: 20)
                                .foregroundColor(isFavorited ? .red : .gray)
                        }
                        
                        
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
        .onAppear{
            pokeViewModel.getPokeImage(url: pokemon.sprites.frontDefault ?? "") { imageOptional in
                self.image = imageOptional
            }
        }
    }
}
