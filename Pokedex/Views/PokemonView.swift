//
//  PokemonView.swift
//  Pokedex
//
//  Created by Ben Blakesley on 08/10/2024.
//

import SwiftUI

struct PokemonView: View {
        
    @ObservedObject var pokeViewModel: PokemonViewModel
    
    var pokeId: Int
    
//    print(pokeViewModel.pokemon[pokeId])
    
    var body: some View {
        ZStack
        {
            if pokeId >= 0 && pokeId < pokeViewModel.pokemon.count {
                let pokemon = pokeViewModel.pokemon[pokeId]
                
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
                                .scaledToFill() // Scale to fill the frame
                                .frame(width: 100, height: 100) // Set your desired frame size
                                .clipped() // Clip the image to fit the frame
                        case .failure:
                            Color.clear // Display nothing if loading fails
                        @unknown default:
                            Color.clear // Handle any future cases
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
                            Text(pokemon.types[0].type.name.capitalized) // Capitalizing the type name
                                 .frame(width: 80)
                                 .foregroundColor(.white)
                                 .background(pokeColors[pokemon.types[0].type.name])
                                 .cornerRadius(10)
                                 .shadow(color: Color.black.opacity(0.3), radius: 4, x: 0, y: 2)
                        }
                        if pokemon.types.indices.contains(1)
                        {
                            Text(pokemon.types[1].type.name.capitalized)
                                 .frame(width: 80)
                                 .foregroundColor(.white)
                                 .background(pokeColors[pokemon.types[1].type.name])
                                 .cornerRadius(10)
                                 .shadow(color: Color.black.opacity(0.3), radius: 4, x: 0, y: 2)
                                 .padding(EdgeInsets(top: 1, leading: 0, bottom: 0, trailing: 0))
                        }
                    }
                }.padding()
            }
        }
        .frame(height: 100)
        .cornerRadius(20)
        .padding(EdgeInsets(top: 0, leading: 10, bottom: 0, trailing: 10))
    }
}

#Preview {    
    PokemonView(pokeViewModel: PokemonViewModel(), pokeId: 1)
}
