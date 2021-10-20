//
//  ImageCell.swift
//  Kristall&Dragon
//
//  Created by Кирилл Заборский on 18.10.2021.
//

import Foundation
import UIKit

class ImageCell: UICollectionViewCell {
    var image: UIImageView?
    
    static let nib = UINib(nibName: Constants.CellReuseIdentifiers.imageCell, bundle: .main)
    var thing: Thing?
    
    func setupImage(_ thingIn: Thing, width: CGFloat, height: CGFloat) {
        thingImage(thingIn.name)
        thing = thingIn
        thing?.coordinate.x %= Int(width)
        thing?.coordinate.y %= Int(height)
        if let view = image {
            view.frame = CGRect(x: 0, y: 0, width: 50, height: 50)
            if !contentView.subviews.isEmpty {
                contentView.subviews.last?.removeFromSuperview()
            }
            contentView.addSubview(view)
        }
    }
    
    private func thingImage(_ thing: Things) {
        switch thing {
        case Things.key:
            image = UIImageView(image: UIImage(named: Constants.PicturesNames.IconNames.key))
        case Things.box:
            image = UIImageView(image: UIImage(named: Constants.PicturesNames.IconNames.closedBox))
        case Things.bone:
            image = UIImageView(image: UIImage(named: Constants.PicturesNames.IconNames.bone))
        case Things.mushroom:
            image = UIImageView(image: UIImage(named: Constants.PicturesNames.IconNames.mushroom))
        case Things.stone:
            image = UIImageView(image: UIImage(named: Constants.PicturesNames.IconNames.stone))
        case Things.food:
            image = UIImageView(image: UIImage(named: Constants.PicturesNames.IconNames.food))
        }
        
    }
    
}
