//
//  StartViewController.swift
//  Kristall&Dragon
//
//  Created by Кирилл Заборский on 14.10.2021.
//

import UIKit
import Lottie

class StartViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var startBtn: UIButton!
    @IBOutlet weak var animationView: AnimationView!
    
    var firstStart = UserDefaults.standard.bool(forKey: "isFirstStart")
    var sound = UserDefaults.standard.bool(forKey: "onSound")
    var currentLevel = UserDefaults.standard.integer(forKey: "level")
    let startButtonText = NSLocalizedString("Start new Game", comment: "")
    let levelButtonText = NSLocalizedString("Start level", comment: "")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initializeHideKeyboard()
        if sound == true {
            SKTAudio.sharedInstance().playBackgroundMusic("sound_game.mp3")
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        animationView.contentMode = .scaleAspectFit
        animationView.loopMode = .loop
        animationView.animationSpeed = 2
        animationView.play()
        
        currentLevel = UserDefaults.standard.integer(forKey: "level")
        firstStart = UserDefaults.standard.bool(forKey: "isFirstStart")
        //print("Уровень на старте \(currentLevel)")
        if currentLevel != 0 {
            startBtn.setTitle("\(levelButtonText) \(currentLevel + 1)", for: .normal)
        } else {
            startBtn.setTitle(startButtonText, for: .normal)
        }
        SKTAudio.sharedInstance().playBackgroundMusic("sound_game.mp3")
        
    }
    
    @IBAction func startNewGameButton(_ sender: Any) {
        SKTAudio.sharedInstance().playSoundEffect("click.mp3")
    }
    
    // MARK: - Navigation
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let controller = segue.destination as? ViewController {
            if firstStart == true {
                UserDefaults.standard.set(false, forKey: "isFirstStart")
                let roomX = 2
                let roomY = 2
                currentLevel = 0
                DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                    controller.labyrinth = CreatorLabyrinth(M: roomX, N: roomY)
                    //print("код запущен")
                }
                controller.level = currentLevel
            } else {
                let roomX = 2 + currentLevel
                let roomY = 2 + currentLevel
                controller.labyrinth = CreatorLabyrinth(M: roomX, N: roomY)
                controller.level = currentLevel
            }
        }
    }
}

extension StartViewController {
    func initializeHideKeyboard(){
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(
            target: self,
            action: #selector(dismissMyKeyboard))
        view.addGestureRecognizer(tap)
    }
    @objc func dismissMyKeyboard(){
        view.endEditing(true)
    }
}
