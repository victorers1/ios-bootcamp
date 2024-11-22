//
//  ViewController.swift
//  EggTimer
//
//  Created by Angela Yu on 08/07/2019.
//  Copyright © 2019 The App Brewery. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
        
    @IBOutlet weak var resultLabel: UILabel!
    
    @IBOutlet weak var progressBar: UIProgressView!
    
    let eggTime = ["Soft": 5, "Medium": 7, "Hard": 12]
    
    var timer: Timer?
    
    override func viewDidLoad() {
        progressBar.progress = 0
    }
    
    @IBAction func hardnessSelected(_ sender: UIButton) {
        timer?.invalidate()
        
        let hardness: String = sender.currentTitle ?? "Soft"
        let totalSeconds: Float = Float(eggTime[hardness] ?? 5)
        var remainingSeconds = totalSeconds
        progressBar.progress = 0
        
        func updateTimer() {
            self.resultLabel.text = "\(Int(remainingSeconds)) seconds remaining"
            progressBar.progress = (totalSeconds - remainingSeconds) / totalSeconds
            remainingSeconds -= 1
        }
        
        updateTimer()
        
        timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) {
            timer in
            
            if remainingSeconds > 0 {
                updateTimer()
            } else {
                timer.invalidate()
                self.progressBar.progress = 1
                self.resultLabel.text = "Done"
            }
        }
    }
    
}
