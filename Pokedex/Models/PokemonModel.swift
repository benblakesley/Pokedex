//
//  PokemonModel.swift
//  Pokedex
//
//  Created by Ben Blakesley on 08/10/2024.
//

import Foundation

struct PokemonModel: Codable, Identifiable
{
    var name: String
    
    var id: Int
    
    var sprites: PokeSprites
    
    var types: [PokeType]
    
    var stats: [Stat]
}



struct PokeSprites: Codable {
    var frontDefault: String?
    var backDefault: String?
    var frontShiny: String?
    var backShiny: String?
    
    enum CodingKeys: String, CodingKey {
        case frontDefault = "front_default"
        case backDefault = "back_default"
        case frontShiny = "front_shiny"
        case backShiny = "back_shiny"
    }
}

struct Stat: Codable
{
    var baseStat: Int // Base value of the stat
    var stat: StatDetail // Details about the stat

    enum CodingKeys: String, CodingKey {
        case baseStat = "base_stat" // Map JSON key to property
        case stat // Nested stat object
    }
}

struct StatDetail: Codable {
    var name: String // Name of the stat (e.g., "hp", "attack")
    var url: String // URL for the stat
}

struct PokeType: Codable
{
    var slot: Int;
    
    var type: Type
}

struct Type: Codable
{
    var name: String
    
    var url: String
}