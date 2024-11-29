//
//  CalculatorBrain.swift
//  BMI Calculator
//
//  Created by Victor Emanuel Ribeiro Silva - VEM on 27/11/24.
//  Copyright © 2024 Angela Yu. All rights reserved.
//

import Foundation

struct CalculatorBrain {
    
    var bmi: BMI?
    
    mutating func calculateBMI(height: Float, weight: Float) {
        let bmiValue = weight / pow(height, 2)
        bmi = BMI(value: bmiValue)
    }
    
    func getBMI() -> BMI {
        return bmi ?? BMI(value: 0.0)
    }
}
