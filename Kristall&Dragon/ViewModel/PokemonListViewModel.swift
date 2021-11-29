//
//  PokemonListViewModel.swift
//  Kristall&Dragon
//
//  Created by Кирилл Заборский on 25.11.2021.
//

import Foundation
import SwiftUI

@MainActor
class PokemonListViewModel: ObservableObject {
    @Published var pokemons = [Pokemon]()
    @ObservedObject var networkMonitor = NetworkMonitor()

    private let networkManager = NetworkManager()

    func getPokemons() async {

        // Отсутствие сети лучше проверять на реальном устройстве,
        // так как значение path.status из NWPathMonitor на симуляторе
        // определяяется неправильно.
        if networkMonitor.isConnected {
            pokemons = try! await networkManager.fetchPokemons()
        }
    }
}
