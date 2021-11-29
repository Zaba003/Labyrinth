//
//  NetworkServices.swift
//  Kristall&Dragon
//
//  Created by Кирилл Заборский on 25.11.2021.
//

import Foundation

class NetworkManager {
    func fetchPokemons() async throws -> [Pokemon] {
        guard let url = URL(string: "https://gist.githubusercontent.com/Zaba003/8ac23ec472b868fda388229fe6554097/raw/92a8b34c1ac8e7b6a722efe7a44f6aa83e1b0d0f/DragonBook") else { throw FetchError.badURL }
        let urlRequest = URLRequest(url: url)

        let (data, response) = try await URLSession.shared.data(for: urlRequest)

        guard (response as? HTTPURLResponse)?.statusCode == 200 else { throw FetchError.badResponse }
        guard let data = data.removeNullsFrom(string: "null,") else { throw FetchError.badData }

        let pokemonData = try JSONDecoder().decode([Pokemon].self, from: data)
        return pokemonData
    }
}
