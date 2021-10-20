//
//  Item.swift
//  Kristall&Dragon
//
//  Created by Кирилл Заборский on 14.10.2021.
//

import Foundation

enum Things: CaseIterable {
    case key
    case box
    case stone
    case mushroom
    case bone
    case food
}

struct Thing {
    let name: Things
    var coordinate: Point
    let description: String
}

extension Thing: Equatable {
    static func == (lhs: Thing, rhs: Thing) -> Bool {
        if lhs.name == rhs.name && lhs.coordinate == rhs.coordinate {
            return true
        }
        return false
    }
}
