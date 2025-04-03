//
//  Gameplay.swift
//  HP Trivia
//
//  Created by Victor Emanuel Ribeiro Silva on 03/04/25.
//

import SwiftUI

struct Gameplay: View {
    var body: some View {
        GeometryReader { geo in
            ZStack {
                Image("hogwarts")
                    .resizable()
                    .frame(width: geo.size.width * 3, height: geo.size.height * 1.05)
                    .overlay(Rectangle().foregroundStyle(.black).opacity(0.8))

                VStack {
                    HStack {
                        Button("End Game") {
                            // TODO: End the game
                        }
                        .buttonStyle(.borderedProminent)
                        .tint(.red.opacity(0.5))

                        Spacer()

                        Text("Score: 33")
                    }
                    .padding()
                    .padding(.vertical, 30)

                    Text("Who is Harry Potter?")
                        .font(.custom(Constants.hpFont, size: 50))
                        .multilineTextAlignment(.center)
                        .padding()

                    Spacer()

                    HStack {
                        Image(systemName: "questionmark.app.fill")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 100)
                            .foregroundStyle(.cyan)
                            .rotationEffect(.degrees(-15))
                            .padding()
                            .padding(.leading, 20)

                        Spacer()

                        Image(systemName: "book.closed")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 50)
                            .foregroundStyle(.black)
                            .frame(width: 100, height: 100)
                            .background(.cyan)
                            .cornerRadius(20)
                            .rotationEffect(.degrees(15))
                            .padding()
                            .padding(.trailing, 20)
                    }.padding(.bottom)

                    // Lazy V Grid

                    LazyVGrid(columns: [GridItem(), GridItem()]) {
                        ForEach(1 ..< 5) { i in
                            Text("Answer \(i)")
                                .minimumScaleFactor(0.5)
                                .multilineTextAlignment(.center)
                                .padding(10)
                                .frame(
                                    width: geo.size.width / 2.15,
                                    height: 80
                                )
                                .background(.green.opacity(0.5))
                                .clipShape(.buttonBorder)
                        }
                    }

                    Spacer()
                }
                .frame(width: geo.size.width, height: geo.size.height)
                .foregroundStyle(.white)
            }
            .frame(width: geo.size.width, height: geo.size.height)

        }.ignoresSafeArea()
    }
}

#Preview {
    Gameplay()
}
