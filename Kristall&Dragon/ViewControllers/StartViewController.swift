//
//  StartViewController.swift
//  Kristall&Dragon
//
//  Created by Кирилл Заборский on 14.10.2021.
//

import UIKit

class StartViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var numberOfRoomX: UITextField!
    @IBOutlet weak var numberOfRoomY: UITextField!
    @IBOutlet weak var startBtn: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        numberOfRoomX.delegate = self
        numberOfRoomY.delegate = self
        setupAddTargetIsNotEmptyTextFields()
        initializeHideKeyboard()
    }
    
    @IBAction func startNewGameButton(_ sender: Any) {
    }
    
    // Разрешаем только цифры
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let allowedCharacters = "1234567890"
        let allowedCharcterSet = CharacterSet(charactersIn: allowedCharacters)
        let typedCharcterSet = CharacterSet(charactersIn: string)
        return allowedCharcterSet.isSuperset(of: typedCharcterSet)
    }
    
    func setupAddTargetIsNotEmptyTextFields() {
        startBtn.isEnabled = false
        numberOfRoomX.addTarget(self, action: #selector(textFieldsIsNotEmpty),
                                    for: .editingChanged)
        numberOfRoomY.addTarget(self, action: #selector(textFieldsIsNotEmpty),
                                    for: .editingChanged)
       }
    
    @objc func textFieldsIsNotEmpty(sender: UITextField) {
        sender.text = sender.text?.trimmingCharacters(in: .whitespaces)
        guard let roomX = numberOfRoomX.text, !roomX.isEmpty, let roomY = numberOfRoomY.text, !roomY.isEmpty else
        {
            self.startBtn.isEnabled = false
            return
        }
        startBtn.isEnabled = true
    }
    
    // MARK: - Navigation
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let controller = segue.destination as? ViewController {
            let roomX: Int = Int(numberOfRoomX.text!) ?? 3
            let roomY: Int = Int(numberOfRoomY.text!) ?? 3
            controller.labyrinth = CreatorLabyrinth(M: roomX, N: roomY)
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
