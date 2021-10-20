//
//  Player.swift
//  Kristall&Dragon
//
//  Created by Кирилл Заборский on 14.10.2021.
//

import Foundation

class Player {
    var idRoom: Int
    var steps = 100
    var inventory: [Things] = []
    var newInventory: [Thing] = []
    
    init(idRoom: Int) {
        self.idRoom = idRoom
    }
}
