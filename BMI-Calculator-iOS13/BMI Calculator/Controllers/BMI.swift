//
//  BMI.swift
//  BMI Calculator
//
//  Created by Victor Emanuel Ribeiro Silva - VEM on 27/11/24.
//  Copyright © 2024 Angela Yu. All rights reserved.
//

import UIKit

struct BMI {
    let value: Float
    let advice: String
    let color: UIColor
    
    var formattedValue: String {
        get { String(format: "%.1f", value) }
    }
    
    init(value: Float) {
        self.value = value
        
        if self.value < 18.5 {
            self.advice = "Underweight"
        } else if self.value > 24.9 {
            self.advice = "Overweight"
        } else {
            self.advice = "Normal"
        }
        
        self.color = UIColor.red
    }
}
