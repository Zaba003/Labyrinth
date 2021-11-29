//
//  PokiDetailViewController.swift
//  Kristall&Dragon
//
//  Created by Кирилл Заборский on 25.11.2021.
//

import UIKit
import SwiftUI

class PokiDetailViewController: UIViewController {

    @IBOutlet weak var containerView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.isNavigationBarHidden = true
        let childView = UIHostingController(rootView: PokemonListView())
        addChild(childView)
        childView.view.frame = containerView.bounds
        containerView.addSubview(childView.view)
        
        NotificationCenter.default.addObserver(forName: NSNotification.Name("dismissSwiftUI"), object: nil, queue: nil) { (_) in
            childView.dismiss(animated: true, completion: nil)
        }
    }
}
