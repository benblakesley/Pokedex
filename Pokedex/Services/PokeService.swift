//
//  PokeService.swift
//  Pokedex
//
//  Created by Ben Blakesley on 08/10/2024.
//

import Foundation

enum MyError: Error
{
    case InvalidURL
    case InvalidResponse
    case ParsingError
}

class PokeService
{
    public func loadPokemon(_ id: Int, completion: @escaping (Result<PokemonModel, MyError>) -> Void) {
        let endpoint = "https://pokeapi.co/api/v2/pokemon/\(id)"
        
        guard let url = URL(string: endpoint) else {
            completion(.failure(.InvalidURL))
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            if error != nil {
                completion(.failure(.InvalidResponse)) // Handle error appropriately
                return
            }
            
            guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
                completion(.failure(.InvalidResponse))
                return
            }
            
            do {
                let decoder = JSONDecoder()
                let pokemon = try decoder.decode(PokemonModel.self, from: data!)
                completion(.success(pokemon))
            } catch {
                completion(.failure(.ParsingError))
            }
        }
        
        task.resume() // Start the network request
    }
}
