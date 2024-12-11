//
//  FeatureSection.swift
//  biometric_core
//
//  Created by Victor Emanuel Ribeiro Silva - VEM on 09/12/24.
//

import SwiftUI

struct FeatureSection : View {
    let title: String
    let buttonText: String
    let onTapButton: () -> Void
    
    init(title: String, buttonText: String?, onTapButton: @escaping () -> Void) {
        self.title = title
        self.onTapButton = onTapButton
        self.buttonText = buttonText ?? "Refresh"
    }
    
    var body: some View {
        VStack(spacing: 16) {
            Text(title).multilineTextAlignment(.center)
            
            Button(
                action: onTapButton,
                label: { 
                    Text(buttonText)
                        .padding(.horizontal, 16)
                        .padding(.vertical, 10)
                        .foregroundColor(.white)
                        .font(.headline)
                }
            ).background(Color.blue)
             .clipShape(Capsule())
             .shadow(color: .gray, radius: 5, x: 0, y: 5)
            
            
            Divider().padding(.top, 16)
        }
    }
}

#Preview {
    Group {
        FeatureSection(
            title: "Title example",
            buttonText: "Button Text",
            onTapButton: { }
        )
        
        Spacer().frame(height: 100)
        
        FeatureSection(
            title: "Title example\nMultiline example",
            buttonText: "Really Long Ass Button Text Example In App With Multiline Example",
            onTapButton: { }
        )
    }
}
