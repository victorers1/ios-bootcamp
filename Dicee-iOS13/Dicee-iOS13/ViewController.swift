//
//  ViewController.swift
//  Dicee-iOS13
//
//  Created by Angela Yu on 11/06/2019.
//  Copyright © 2019 London App Brewery. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    // IBOutlet: data presented in the UI
    @IBOutlet weak var backgroundImage: UIImageView!
    
    @IBOutlet weak var leftDiceImageView: UIImageView!
    
    @IBOutlet weak var rightDiceImageView: UIImageView!
    
    let diceFaces: [UIImage] = [
        UIImage(imageLiteralResourceName: "DiceOne"),
        UIImage(imageLiteralResourceName: "DiceTwo"),
        UIImage(imageLiteralResourceName: "DiceThree"),
        UIImage(imageLiteralResourceName: "DiceFour"),
        UIImage(imageLiteralResourceName: "DiceFive"),
        UIImage(imageLiteralResourceName: "DiceSix"),
    ]
    
    // IBAction: action done in UI that triggers code to be run
    @IBAction func rollButtonPressed(_ sender: UIButton) {
        leftDiceImageView.image = diceFaces[Int.random(in: 0...5)]
        rightDiceImageView.image = diceFaces[Int.random(in: 0...5)]
    }
    
}

