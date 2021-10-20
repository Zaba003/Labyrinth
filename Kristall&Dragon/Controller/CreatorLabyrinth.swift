//
//  CreatorLabyirint.swift
//  Kristall&Dragon
//
//  Created by Кирилл Заборский on 15.10.2021.
//

import Foundation

class CreatorLabyrinth {
    
    private let M, N: Int
    var rooms: [Room] = []
    let player: Player
    
    init(M: Int, N: Int) {
        self.M = M
        self.N = N
        
        // Генерируем комнаты
        for i in 0..<N {
            for j in 0..<M {
                self.rooms.append(Room(id: i * M + j))
                rooms.last?.generateThings()
            }
        }
        
        // Генерируем двери и привязываем к комнатам
        for room in rooms {
            let idChanges = room.generateDoors(M, N)
            for elem in idChanges {
                    rooms[elem[0]].doors[elem[1]] = room.id
            }
        }
        
        let playerRoom = Int.random(in: 0..<M * N)
        self.player = Player(idRoom: playerRoom)
        
        // Доступные комнаты для игрока
        var playerRooms: [Int] = [playerRoom]
        for room in playerRooms {
            for door in rooms[room].doors {
                if door != -1 && !playerRooms.contains(door) {
                    playerRooms.append(door)
                }
            }
        }
        
        // Раставляем ключ и сундук
        let idBoxRoom = playerRooms[Int.random(in: 0..<playerRooms.count)]
        let idKeyRoom = playerRooms[Int.random(in: 0..<playerRooms.count)]
        
        rooms[idBoxRoom].things.append(Thing(name: .box,
                                             coordinate: Point(x: 50,
                                                               y: 50),
                                             description: "box"))
        rooms[idKeyRoom].things.append(Thing(name: .key,
                                             coordinate: Point(x: 50,
                                                               y: 0),
                                             description: "key"))
        
        // Считаем шаги
        self.player.steps = CreatorLabyrinth.breadthFirstSearch(idStart: playerRoom,
                                                       idEnd: idKeyRoom,
                                                       rooms: self.rooms)
        self.player.steps += CreatorLabyrinth.breadthFirstSearch(idStart: idKeyRoom,
                                                        idEnd: idBoxRoom,
                                                        rooms: self.rooms) + 1
    }
    
    
    static private func breadthFirstSearch(idStart:Int, idEnd: Int, rooms: [Room])-> Int {
        var queue = [idStart]
        var visitedRooms: Set<Int> = [idStart]
        var parent: [Int: Int] = [idStart: idStart]
        
        while let visitedRoom = queue.first {
            queue.removeFirst()
            
            if visitedRoom == idEnd {
                break
            }
            for door in rooms[visitedRoom].doors {
                if door != -1 && !visitedRooms.contains(door) {
                    queue.append(door)
                    visitedRooms.insert(door)
                    parent[door] = visitedRoom
                }
            }
        }
        
        var room = idEnd
        var lengthWay = 0
        while room != idStart {
            guard let parent = parent[room] else {
                return -1
            }
            room = parent
            lengthWay += 1
        }
        
        return lengthWay
    }
}
