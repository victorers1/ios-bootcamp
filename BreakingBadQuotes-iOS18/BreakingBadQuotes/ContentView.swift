//
//  ContentView.swift
//  BreakingBadQuotes
//
//  Created by Victor Emanuel Ribeiro Silva on 21/03/25.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        TabView {
            Tab(Constants.BreakingBadName, systemImage: "tortoise") {
                FetchView(show: Constants.BreakingBadName)
            }

            Tab(Constants.BetterCallSaulName, systemImage: "briefcase") {
                FetchView(show: Constants.BetterCallSaulName)
            }

            Tab(Constants.ElCamino, systemImage: "car") {
                FetchView(show: Constants.ElCamino)
            }
        }.preferredColorScheme(.dark)
            
    }
}

#Preview {
    ContentView()
}
