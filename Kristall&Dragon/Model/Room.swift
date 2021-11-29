//
//  Room.swift
//  Kristall&Dragon
//
//  Created by Кирилл Заборский on 14.10.2021.
//

import Foundation

class Room {
    let id: Int
    // Массив смежных комнат
    var doors: [Int] = [-1, -1, -1, -1]
    var things: [Thing] = []
    var polygon: [Point] = []
    let currentLevel = UserDefaults.standard.integer(forKey: "level")
    
    init(id: Int) {
        self.id = id
    }
    
    func generateDoors(_ M: Int, _ N: Int) -> [[Int]] {
        
        doors = [-1, -1, -1, -1]
        var idChanges: [[Int]] = []
        
        if N > 1 && M > 1 {
            // определяем направления установки дверей
            var exceptions: Set<Int> = []
            let i = id / M, j = id % M
            if j == 0 {
                exceptions.insert(0)
            }
            if j == M - 1 {
                exceptions.insert(1)
            }
            if i == 0 {
                exceptions.insert(3)
            }
            if i == N - 1 {
                exceptions.insert(2)
            }
            let sides: Set<Int> = [0, 1, 2, 3] // left, right, down, top
            let directions = sides.subtracting(exceptions)
            
            // Устанавливаем двери
            let doorsCount = Int.random(in: 1...directions.count)
            for _ in 0...doorsCount {
                let direction = directions.randomElement()
                switch direction {
                case 0:
                    doors[0] = id - 1
                    idChanges.append([id - 1, 1])
                case 1:
                    doors[1] = id + 1
                    idChanges.append([id + 1, 0])
                case 2:
                    doors[2] = id + M
                    idChanges.append([id + M, 3])
                case 3:
                    doors[3] = id - M
                    idChanges.append([id - M, 2])
                default:
                    break
                }
            }
        }
        return idChanges
    }
    
    func generateThings() {
        things = []
        polygon = []
        
        var count = 0
        // Добавляем рандомно вещи в комнаты
        if currentLevel <= 5 {
            count = Int.random(in: 0...2)
        } else if currentLevel >= 6 && currentLevel <= 10 {
            count = Int.random(in: 0...3)
        } else if currentLevel >= 11 {
            count = Int.random(in: 0...4)
        }
        
        let countThings = count
        
        let things = Set<Things>(Things.allCases)
            .subtracting(Set<Things>([.key, .box, .book]))
        
        let cellX = UserDefaults.standard.integer(forKey: "width") / 50
        let cellY = UserDefaults.standard.integer(forKey: "height") / 50
        
        
        var coordX = 0
        var coordY = 0
        
        for _ in 0..<cellX {
            for _ in 0..<cellY {
                let coord = Point(x: coordX, y: coordY)
                polygon.append(coord)
                coordY += 50
            }
            coordY = 0
            coordX += 50
        }
        
        for _ in 0..<countThings {
            if let thing = things.randomElement() {
                
                let numberElement = Int.random(in: 0..<polygon.count)
                let randomX = polygon[numberElement]
                //print(randomX)
                polygon.remove(at: numberElement)
                
                let coordinate = Point(x: randomX.x, y: randomX.y)
                
                var description = ""
                switch thing {
                case Things.bone:
                    description = "Bone"
                case Things.mushroom:
                    description = "Mushroom"
                case Things.stone:
                    description = "Stone"
                case Things.food:
                    description = "Food"
                case Things.book:
                    description = "Book"
                default:
                    break
                }
                self.things.append(Thing(name: thing,
                                         coordinate: coordinate,
                                         description: description))
            }
        }
    }
    
}
