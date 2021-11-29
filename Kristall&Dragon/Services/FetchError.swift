//
//  FetchError.swift
//  Kristall&Dragon
//
//  Created by Кирилл Заборский on 25.11.2021.
//

import Foundation

enum FetchError: Error {
    case badURL
    case badResponse
    case badData
}
