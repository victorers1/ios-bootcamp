//
//  ViewController.swift
//  Xylophone
//
//  Created by Angela Yu on 28/06/2019.
//  Copyright © 2019 The App Brewery. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {
    
    var player: AVAudioPlayer?
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func keyPressed(_ sender: UIButton) {
        playSound(chord: sender.titleLabel?.text ?? "C")
        
        let originalColor = sender.backgroundColor
        
        sender.alpha = 0.5
        
        DispatchQueue.main.asyncAfter(deadline: .now() + .milliseconds(200)) {
            sender.alpha = 1
        }
    }
    
    
    func playSound(chord: String) {
        let url = Bundle.main.url(forResource: chord, withExtension: "wav")
        
        player = try! AVAudioPlayer(contentsOf: url!)
        
        player?.play()
        
    }
    
}

