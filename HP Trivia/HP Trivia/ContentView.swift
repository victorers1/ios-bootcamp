//
//  ContentView.swift
//  HP Trivia
//
//  Created by Victor Emanuel Ribeiro Silva on 02/04/25.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        GeometryReader { geo in
            ZStack {
                Image("hogwarts")
                    .resizable()
                    .frame(width: geo.size.width * 3, height: geo.size.height)
                    .padding(.top, 3)

                VStack {
                    VStack {
                        Image(systemName: "bolt.fill")
                            .font(.largeTitle)
                            .imageScale(.large)

                        Text("HP")
                            .font(.custom(Constants.hpFont, size: 70))
                            .padding(.bottom, -50)

                        Text("Trivia")
                            .font(.custom(Constants.hpFont, size: 60))
                    }.padding(.top, 70)

                    Spacer()

                    VStack {
                        Text("Recent Scores")
                            .font(.title2)

                        Text("33")
                        Text("27")
                        Text("15")
                    }
                    .font(.title3)
                    .padding(.horizontal)
                    .foregroundStyle(.white)
                    .background(.black.opacity(0.7))
                    .cornerRadius(15)

                    Spacer()

                    HStack {
                        Spacer()

                        Button {
                            // show instructions
                        } label: {
                            Image(systemName: "info.circle.fill")
                                .font(.largeTitle)
                                .foregroundStyle(.white)
                                .shadow(radius: 5)
                        }

                        Spacer()

                        Button {
                            // Play new game
                        } label: {
                            Text("Play")
                                .font(.largeTitle)
                                .foregroundStyle(.white)
                                .padding(.vertical, 7)
                                .padding(.horizontal, 50)
                                .background(.brown)
                                .clipShape(.capsule)
                                .shadow(radius: 5)
                        }

                        Spacer()

                        Button {
                            // Show setting screen
                        } label: {
                            Image(systemName: "gearshape.fill")
                                .font(.largeTitle)
                                .foregroundStyle(.white)
                                .shadow(radius: 5)
                        }

                        Spacer()
                    }
                    .frame(width: geo.size.width)

                    Spacer()
                }
            }
            .frame(width: geo.size.width, height: geo.size.height)
        }
        .ignoresSafeArea()
    }
}

#Preview {
    ContentView()
}
