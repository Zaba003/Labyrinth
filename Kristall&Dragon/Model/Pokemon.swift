//
//  Pokemon.swift
//  Kristall&Dragon
//
//  Created by Кирилл Заборский on 25.11.2021.
//

import SwiftUI

struct Pokemon: Identifiable, Decodable {
    var isFavorite = false

    let id: Int
    let name: String
    let imageURL: String
    let type: String

    let description: String
    let attack: Int
    let defense: Int
    let height: Int
    let weight: Int

    enum CodingKeys: String, CodingKey {
        case id
        case name
        case imageURL = "imageUrl"
        case type
        case description
        case attack
        case defense
        case height
        case weight
    }

    var typeColor: Color {
        switch type {
        case "fire":
            return Color(.systemRed)
        case "poison":
            return Color(.systemGreen)
        case "water":
            return Color(.systemTeal)
        case "electric":
            return Color(.systemYellow)
        case "psychic":
            return Color(.systemPurple)
        case "normal":
            return Color(.systemOrange)
        case "ground":
            return Color(.systemBrown)
        case "flying":
            return Color(.systemMint)
        case "fairy":
            return Color(.systemPink)
        default:
            return Color(.systemIndigo)
        }
    }
}
