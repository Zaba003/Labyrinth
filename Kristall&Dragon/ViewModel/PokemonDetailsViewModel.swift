//
//  PokemonDetailsModel.swift
//  Kristall&Dragon
//
//  Created by Кирилл Заборский on 25.11.2021.
//

import SwiftUI

class PokemonDetailsViewModel: ObservableObject {
    @Published var pokemon: Pokemon

    init(pokemon: Pokemon) {
        self.pokemon = pokemon
    }
}
