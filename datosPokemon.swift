//
//  datosPokemon.swift
//  pokedex
//
//  Created by Valeria Muñoz toro on 21-07-22.
//

import Foundation

struct Pokemon: Decodable, Identifiable{
    let id: Int
    let attack: Int
    let name: String
    let imageUrl: String
    let defense: Int
    let description: String
    let type: String
}
