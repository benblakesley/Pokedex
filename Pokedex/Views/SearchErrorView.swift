//
//  SearchErrorView.swift
//  Pokedex
//
//  Created by Ben Blakesley on 13/10/2024.
//

import SwiftUI

struct SearchErrorView: View {
    
    var psyduck: PokemonModel
    
    var body: some View {
        VStack
        {
            AsyncImage(url: URL(string: psyduck.sprites.frontDefault ?? "")) { phase in
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
            
            Text("Psyduck is confused—no matches found!")
                .font(.title)
                .multilineTextAlignment(.center)
        }
    }
}
