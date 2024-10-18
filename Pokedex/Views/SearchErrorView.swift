//
//  SearchErrorView.swift
//  Pokedex
//
//  Created by Ben Blakesley on 13/10/2024.
//

import SwiftUI

struct SearchErrorView: View {
    
    var psyduck: PokemonModel
    
    @State private var image: UIImage?
    
    @EnvironmentObject var pokeViewModel: PokemonViewModel
    
    var body: some View {
        VStack
        {
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
            
            Text("Psyduck is confused—no matches found!")
                .font(.title)
                .multilineTextAlignment(.center)
        }
        .onAppear{
            pokeViewModel.getPokeImage(url: psyduck.sprites.frontDefault ?? "") { imageOptional in
                self.image = imageOptional
            }
        }
    }
}
