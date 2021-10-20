//
//  ViewController.swift
//  Kristall&Dragon
//
//  Created by Кирилл Заборский on 14.10.2021.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak private var stepsLabel: UILabel!
    @IBOutlet weak private var roomView: UIView!
    @IBOutlet weak private var inventoryCollectionView: UICollectionView!
    
    @IBOutlet weak private var upButton: UIButton!
    @IBOutlet weak private var rightButton: UIButton!
    @IBOutlet weak private var leftButton: UIButton!
    @IBOutlet weak private var downButton: UIButton!
    
    @IBOutlet weak private var useButton: UIButton!
    @IBOutlet weak private var dropButton: UIButton!
    @IBOutlet weak private var discardButton: UIButton!
    
    @IBOutlet weak var thingDescription: UILabel!
    
    var labyrinth: CreatorLabyrinth?
    private var selectedThing: Thing?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let imageCellNib = UINib(nibName: Constants.NibNames.imageCellNib,
                                 bundle: nil)
        inventoryCollectionView.delegate = self
        inventoryCollectionView.dataSource = self
        inventoryCollectionView
            .register(imageCellNib,
                      forCellWithReuseIdentifier: Constants.CellReuseIdentifiers.imageCell)
        
        create()
    }
    
    @IBAction func upButtonAction(_ sender: Any) {
        nextDoor(3)
    }
    
    @IBAction func leftButtonAction(_ sender: Any) {
        nextDoor(0)
    }
    
    @IBAction func downButtonAction(_ sender: Any) {
        nextDoor(2)
    }
    
    @IBAction func rightButtonAction(_ sender: Any) {
        nextDoor(1)
    }
    
    @IBAction func didTapUseButton(_ sender: Any) {
        guard let thing = selectedThing else { return }
        if thing.name == Things.key {
            for view in roomView.subviews {
                if let image = view as? ImageCell,
                   image.thing?.name == Things.box,
                   let thing = image.thing {
                    roomView.addSubview(UIImageView(image: UIImage(named:
                                                                    Constants.PicturesNames.IconNames.openedBox)))
                    roomView.subviews.last?
                        .frame = CGRect(x: thing.coordinate.x,
                                        y: thing.coordinate.y,
                                        width: 50,
                                        height: 50)
                    view.removeFromSuperview()
                    
                    setInventoryButton()
                    
                    let alert = UIAlertController(
                        title: "WOW! Super",
                        message: "You are WIN!",
                        preferredStyle: .alert
                    )
                    
                    alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { _ in
                        self.dismiss(animated: true, completion: nil)
                    }))
                    self.present(alert, animated: true)
                    break
                }
            }
        }
        
        guard var inventory = labyrinth?.player.newInventory else { return }
        for i in 0..<inventory.count {
            if inventory[i].description == "Food" {
                inventory.remove(at: i)
                let labirint = labyrinth
                labirint?.player.newInventory.remove(at: i)
                labirint?.player.steps += 4
                inventoryCollectionView.reloadData()
                setInventoryButton()
                create()
                break
            }
        }
    }
    
    @IBAction func didTapDropButton(_ sender: Any) {
        guard let thing = selectedThing, let labirint = labyrinth else {
            return
        }
        let image = ImageCell()
        image.setupImage(thing, width: roomView.frame.width,
                         height: roomView.frame.height)
        roomView.addSubview(image)
        roomView.subviews.last?.frame = CGRect(x: thing.coordinate.x,
                                               y: thing.coordinate.y,
                                               width: 50,
                                               height: 50)
        let tap = UITapGestureRecognizer(target: self,
                                         action: #selector(self
                                                            .didTapImage(_:)))
        roomView.subviews.last?.addGestureRecognizer(tap)
        roomView.subviews.last?.isUserInteractionEnabled = true
        labirint.rooms[labirint.player.idRoom].things.append(thing)
        let inventory = labirint.player.newInventory
        for i in 0..<inventory.count {
            if inventory[i].name == thing.name {
                labirint.player.newInventory.remove(at: i)
                inventoryCollectionView.reloadData()
                setInventoryButton()
                break
            }
        }
    }
    
    @IBAction func DidTapDiscardButton(_ sender: Any) {
        guard let thing = selectedThing, let labirint = labyrinth,
              thing.name != Things.key else { return }
        let inventory = labirint.player.newInventory
        for i in 0..<inventory.count {
            if inventory[i].name == thing.name {
                labirint.player.newInventory.remove(at: i)
                inventoryCollectionView.reloadData()
                setInventoryButton()
                break
            }
        }
    }
    
    private func setInventoryButton() {
        selectedThing = nil
        useButton.isEnabled = false
        dropButton.isEnabled = false
        discardButton.isEnabled = false
        thingDescription.text = ""
    }
}

// MARK: - Draw room
private extension ViewController {
    func nextDoor(_ direction: Int) {
        guard let labirint = labyrinth, labirint.player.steps != 0 else {
            return
        }
        
        let idRoom = labirint.player.idRoom
        labirint.player.idRoom = labirint.rooms[idRoom].doors[direction]
        labirint.player.steps -= 1
        create()
        
        if labirint.player.steps == 0 && (!isRoomThing(Things.box) || !(isRoomThing(.key) || isInventoryThing(.key))){
            let alert = UIAlertController(
                title: "You lose...",
                message: "Use food to refill steps!",
                preferredStyle: .alert
            )
            
            alert.addAction(UIAlertAction(title: "OK!", style: .default, handler: { _ in
                self.dismiss(animated: true, completion: nil)
            }))
            self.present(alert, animated: true)
        }
    }
    
    func create() {
        guard let labirint = labyrinth else { return }
        stepsLabel.text = "Steps: " + String(labirint.player.steps)
        createDoors()
        drawThings()
    }
    
    func drawThings() {
        guard let labirint = labyrinth else { return }
        let idRoom = labirint.player.idRoom
        let things = labirint.rooms[idRoom].things
        
        // Очищаем текущую
        for view in roomView.subviews {
            view.removeFromSuperview()
        }
        
        // Добавляем вещи в комнаты
        for thing in things {
            let image = ImageCell()
            image.setupImage(thing, width: roomView.frame.width,
                             height: roomView.frame.height)
            roomView.addSubview(image)
            roomView.subviews.last?.frame = CGRect(x: thing.coordinate.x,
                                                   y: thing.coordinate.y,
                                                   width: 50,
                                                   height: 50)
            if(thing.name != Things.box) {
                let tap = UITapGestureRecognizer(target: self,
                                                 action: #selector(self
                                                                    .didTapImage(_:)))
                roomView.subviews.last?.addGestureRecognizer(tap)
                roomView.subviews.last?.isUserInteractionEnabled = true
            }
        }
    }
    
    func createDoors() {
        guard let labirint = labyrinth else { return }
        let idRoom = labirint.player.idRoom
        let doors = labirint.rooms[idRoom].doors
        
        for i in 0 ..< doors.count {
            switch i {
            case 0:
                if doors[i] == -1 {
                    leftButton.isHidden = true
                } else {
                    leftButton.isHidden = false
                }
            case 1:
                if doors[i] == -1 {
                    rightButton.isHidden = true
                } else {
                    rightButton.isHidden = false
                }
            case 2:
                if doors[i] == -1 {
                    downButton.isHidden = true
                } else {
                    downButton.isHidden = false
                }
            case 3:
                if doors[i] == -1 {
                    upButton.isHidden = true
                } else {
                    upButton.isHidden = false
                }
            default:
                break
            }
        }
    }
}

// MARK: - Tap Image
private extension ViewController {
    @objc func didTapImage(_ sender: UITapGestureRecognizer) {
        guard let view = sender.view else { return }
        guard let labirint = labyrinth else { return }
        if roomView.subviews.contains(view) {
            if let image = view as? ImageCell,
               let thing = image.thing,
               labirint.player.newInventory.count < 5 {
                labirint.player.newInventory.append(thing)
                let id = labirint.player.idRoom
                let things = labirint.rooms[id].things
                for i in 0..<things.count {
                    if thing == things[i] {
                        labirint.rooms[id].things.remove(at: i)
                        break
                    }
                }
                view.removeFromSuperview()
                inventoryCollectionView.reloadData()
            }
        }
    }
}

// MARK: - Collection Delegate
extension ViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let labirint = labyrinth else { return }
        selectedThing = labirint.player.newInventory[indexPath.row]
        useButton.isEnabled = true
        dropButton.isEnabled = true
        discardButton.isEnabled = true
        if selectedThing?.description == "Food" {
            thingDescription.text = "Food. Restores energy for 4 steps"
        } else {
            thingDescription.text = selectedThing?.description ?? ""
        }
    }
}

extension ViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let labirint = labyrinth else { return UICollectionViewCell() }
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Constants.CellReuseIdentifiers.imageCell, for: indexPath) as? ImageCell else {
            return UICollectionViewCell()
        }
        let image = labirint.player.newInventory[indexPath.row]
        
        cell.setupImage(image,
                        width: roomView.frame.width,
                        height: roomView.frame.height)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        guard let context = labyrinth else { return 0 }
        return context.player.newInventory.count
    }
}

// MARK: - Thing belonging func
private extension ViewController {
    func isRoomThing(_ thing: Things) -> Bool {
        for view in roomView.subviews {
            if let image = view as? ImageCell,
               image.thing?.name == thing {
                return true
            }
        }
        return false
    }
    
    func isInventoryThing(_ thing: Things) -> Bool {
        guard let inventory = labyrinth?.player.inventory else { return false }
        for inventory in inventory.enumerated() {
            if inventory.element == thing {
                return true
            }
        }
        return false
    }
}

