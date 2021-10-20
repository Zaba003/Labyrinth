//
//  Point.swift
//  Kristall&Dragon
//
//  Created by Кирилл Заборский on 18.10.2021.
//

import Foundation

struct Point {
    var x,y: Int
}

extension Point: Equatable {
    static func == (lhs: Point, rhs: Point) -> Bool {
        if lhs.x == rhs.x && lhs.y == rhs.y {
            return true
        }
        return false
    }
    
}
