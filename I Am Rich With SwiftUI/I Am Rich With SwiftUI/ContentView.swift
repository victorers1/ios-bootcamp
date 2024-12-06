//
//  ContentView.swift
//  I Am Rich With SwiftUI
//
//  Created by Victor Emanuel Ribeiro Silva - VEM on 04/12/24.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        ZStack(content: {

            Color(.systemTeal).edgesIgnoringSafeArea(/*@START_MENU_TOKEN@*/.all/*@END_MENU_TOKEN@*/)
            
            VStack {
                Spacer()
                Text("I Am Rich").bold().colorInvert()
                Spacer()
                Image("diamond")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .foregroundStyle(.tint)
                Spacer()
            }
            .padding()
            
        })
        
    }
}

#Preview {
    ContentView()
}
