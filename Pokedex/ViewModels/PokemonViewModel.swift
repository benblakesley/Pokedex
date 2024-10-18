//
//  PokemonViewModel.swift
//  Pokedex
//
//  Created by Ben Blakesley on 08/10/2024.
//

import Foundation
import SwiftUI


class PokemonViewModel: ObservableObject
{
    @Published var pokemon: [PokemonModel] = []

    private let pokeService = PokeService()
    
    private var manager = ImageCacheManager.instance
    
    private var imageLoader = ImageLeader()
    
    @AppStorage("favoritedPokemonIds") private var favoritedPokemonIdsData: Data = Data()

    func getPokeImage(url: String, completion: @escaping (UIImage?) -> Void)
    {
        // If image in cache, then get it
        if let image = manager.getImage(name: url)
        {
            completion(image)
            return
        }
        
        // else if image not in cache then go fetch it
        imageLoader.fetchImage(url: url) { image in
            if let pokeImage = image
            {
                // if image fetched successfully then add it to cache
                self.manager.addImage(image: pokeImage, name: url)
            }
        completion(image)
        }
    }

    
    public func generatePokemon()
    {
        (1...151).forEach{(index) in
                self.pokeService.loadPokemon(index) { (result) in
                    
                    DispatchQueue.main.async {
                        switch result {
                        case .success(let pokemon):
                            self.pokemon.append(pokemon)
                            self.pokemon.sort{ $0.id < $1.id }
                        case .failure(let error):
                            print(error)
                        }
                    }
                }
            }}
     
    private var favoritedPokemonIds: Set<Int> {
           get {
               if let ids = try? JSONDecoder().decode(Set<Int>.self, from: favoritedPokemonIdsData) {
                   return ids
               }
               return []
           }
           set {
               if let data = try? JSONEncoder().encode(newValue) {
                   favoritedPokemonIdsData = data
               }
           }
        }
    
    public func toggleFavorite(for pokemon: PokemonModel) {
           if favoritedPokemonIds.contains(pokemon.id) {
               favoritedPokemonIds.remove(pokemon.id) // Unfavorite
           } else {
               favoritedPokemonIds.insert(pokemon.id) // Favorite
           }
       }

    public func isFavorited(pokemon: PokemonModel) -> Bool {
            favoritedPokemonIds.contains(pokemon.id)
        }
    
    public func getFavorites(pokemom: [PokemonModel]) -> [PokemonModel]
    {
        var favorites: [PokemonModel] = []
        
        pokemom.forEach { poke in
            
            if isFavorited(pokemon: poke)
            {
                favorites.append(poke)
            }
        }
        return favorites
    }
    
}
