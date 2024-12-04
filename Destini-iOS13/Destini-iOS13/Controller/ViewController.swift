//
//  ViewController.swift
//  Destini-iOS13
//
//  Created by Angela Yu on 08/08/2019.
//  Copyright © 2019 The App Brewery. All rights reserved.
//

import UIKit
import CLTypingLabel

class ViewController: UIViewController {

    @IBOutlet weak var storyLabel: CLTypingLabel!
    @IBOutlet weak var choice1Button: UIButton!
    @IBOutlet weak var choice2Button: UIButton!
    
    var storyBrain = StoryBrain()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        storyLabel.charInterval = 0.04
        storyLabel.text = storyBrain.currentStory.title
        choice1Button.setTitle(storyBrain.currentStory.choice1, for: .normal)
        choice2Button.setTitle(storyBrain.currentStory.choice2, for: .normal)

    }
    
    @IBAction func choiceMade(_ sender: UIButton) {
        storyBrain.nextStory(choiceMade: sender.titleLabel?.text ?? "")
        
        updateUI()
    }
    
    func updateUI() {
        storyLabel.text = storyBrain.currentStory.title
        choice1Button.setTitle(storyBrain.currentStory.choice1, for: .normal)
        choice2Button.setTitle(storyBrain.currentStory.choice2, for: .normal)
//        choice1Button.titleLabel?.text = storyBrain.currentStory.choice1
//        choice2Button.titleLabel?.text = storyBrain.currentStory.choice2
    }
    
}

