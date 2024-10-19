//
//  PokemonSheetView.swift
//  Pokedex
//
//  Created by Ben Blakesley on 11/10/2024.
//

import SwiftUI

struct PokemonSheetView: View {
    
    @Environment(\.dismiss) var dismiss
    
    var pokemon: PokemonModel
    
    @State private var image: UIImage?
    
    @EnvironmentObject var pokeViewModel: PokemonViewModel
    
    @Environment(\.colorScheme) var colorScheme
    
    var body: some View {
        
        let isDarkMode = (colorScheme == .dark)
        ZStack
        {
            if pokemon.types.count > 1
            {
                let color1 = pokeColors[pokemon.types[0].type.name]
                let color2 = pokeColors[pokemon.types[1].type.name]
                
                LinearGradient(gradient: Gradient(colors: [color1!, color2!]),
                               startPoint: .top,
                               endPoint: .bottom).opacity(isDarkMode ? 1 : 0.5)
            }
            else if pokemon.types.count == 1
            {
                pokeColors[pokemon.types[0].type.name]
                    .opacity(isDarkMode ? 1 : 0.5)
            }
            
            VStack
            {
                HStack
                {
                    Spacer()
                    
                    Button {
                        dismiss()
                    } label: {
                        Image(systemName: "xmark")
                            .foregroundColor(.white)
                            .font(.title)
                            .padding(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 20))
                    }
                }

     
                Text("#\(pokemon.id) \(pokemon.name.capitalized)")
                    .font(.title)
                    .fontWeight(.heavy)
                    .foregroundColor(.white)
                    .padding(EdgeInsets(top: 0, leading: 0, bottom: 10, trailing: 0))

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
                
                if let image = self.image
                {
                    Image(uiImage: image)
                        .resizable()
                        .scaledToFill()
                        .frame(width: 300, height: 300)
                        .clipped()
                }
                else
                {
                    Color.clear
                        .frame(width: 300, height: 300)
                }
                
                StatsChartView(stats: pokemon.stats)
            }
        }
        .ignoresSafeArea()
        .onAppear{
            pokeViewModel.getPokeImage(url: pokemon.sprites.frontDefault ?? "") { imageOptional in
                self.image = imageOptional
            }
        }
    }
}
