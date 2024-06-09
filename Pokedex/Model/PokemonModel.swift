//
//  PokemonModel.swift
//  Pokedex
//
//  Created by Cesar Mendez Santos on 06/06/24.
//

import Foundation

struct PokemonModel: Codable, Hashable {
    let id: Int
    let attack: Int
    let defense: Int
    let description: String
    let name: String
    let imageUrl: String
    let type: String
}
