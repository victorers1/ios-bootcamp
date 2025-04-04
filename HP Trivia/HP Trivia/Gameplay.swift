//
//  Gameplay.swift
//  HP Trivia
//
//  Created by Victor Emanuel Ribeiro Silva on 03/04/25.
//

import SwiftUI

struct Gameplay: View {
    @Environment(\.dismiss) private var dismiss

    @State private var animateViewsIn = false
    @State private var tappedCorrectAnswer = false

    @State private var revealHint = false
    @State private var revealBook = false

    @Namespace private var namespace

    let tempAnswers = [true, false, false, false]

    var body: some View {
        GeometryReader { geo in
            ZStack {
                Image("hogwarts")
                    .resizable()
                    .frame(width: geo.size.width * 3, height: geo.size.height * 1.05)
                    .overlay(Rectangle().foregroundStyle(.black).opacity(0.8))

                VStack {
                    // MARK: Header

                    HStack {
                        Button("End Game") {
                            dismiss()
                        }
                        .buttonStyle(.borderedProminent)
                        .tint(.red.opacity(0.5))

                        Spacer()

                        Text("Score: 33")
                    }
                    .padding()
                    .padding(.vertical, 30)

                    // MARK: Question

                    VStack {
                        if animateViewsIn {
                            Text("Who is Harry Potter?")
                                .font(.custom(Constants.hpFont, size: 50))
                                .multilineTextAlignment(.center)
                                .padding()
                                .transition(.scale)
                        }
                    }.animation(.easeInOut(duration: 2), value: animateViewsIn)

                    Spacer()

                    // MARK: Hints

                    HStack {
                        VStack {
                            if animateViewsIn {
                                Image(systemName: "questionmark.app.fill")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 100)
                                    .foregroundStyle(.cyan)
                                    .rotationEffect(.degrees(-15))
                                    .padding()
                                    .padding(.leading, 20)
                                    .transition(.offset(x: -geo.size.width / 2))
                                    .onTapGesture {
                                        withAnimation(.easeOut(duration: 1)) {
                                            revealHint = true
                                        }
                                    }.rotation3DEffect(
                                        .degrees(revealHint ? 1440 : 0),
                                        axis: (x: 0, y: 1, z: 0)
                                    )
                                    .scaleEffect(revealHint ? 5 : 1)
                                    .opacity(revealHint ? 0 : 1)
                                    .offset(x: revealHint ? geo.size.width / 2 : 0)
                                    .overlay {
                                        Text("The boy who _______")
                                            .padding(.leading, 33)
                                            .minimumScaleFactor(0.5)
                                            .multilineTextAlignment(.center)
                                            .opacity(revealHint ? 1 : 0)
                                            .scaleEffect(revealHint ? 1.33 : 1)
                                    }
                            }
                        }.animation(.easeOut(duration: 1.5).delay(2), value: animateViewsIn)

                        Spacer()

                        VStack {
                            if animateViewsIn {
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
                                    .transition(.offset(x: geo.size.width / 2))
                                    .onTapGesture {
                                        withAnimation(.easeOut(duration: 1)) {
                                            revealBook = true
                                        }
                                    }.rotation3DEffect(
                                        .degrees(revealBook ? 1440 : 0),
                                        axis: (x: 0, y: 1, z: 0)
                                    )
                                    .scaleEffect(revealBook ? 5 : 1)
                                    .opacity(revealBook ? 0 : 1)
                                    .offset(x: revealBook ? -geo.size.width / 2 : 0)
                                    .overlay {
                                        Image("hp1")
                                            .resizable()
                                            .scaledToFit()
                                            .padding(.trailing, 33)
                                            .opacity(revealBook ? 1 : 0)
                                            .scaleEffect(revealBook ? 1.33 : 1)
                                    }
                            }
                        }
                        .animation(.easeOut(duration: 1.5).delay(2), value: animateViewsIn)

                    }.padding(.bottom)

                    // MARK: Answers

                    LazyVGrid(columns: [GridItem(), GridItem()]) {
                        ForEach(1 ..< 5) { i in
                            
                            if tempAnswers[i-1] {
                                
                            }
                            VStack {
                                if animateViewsIn {
                                    Text("Answer \(i)")
                                        .minimumScaleFactor(0.5)
                                        .multilineTextAlignment(.center)
                                        .padding(10)
                                        .frame(width: geo.size.width / 2.15, height: 80)
                                        .background(.green.opacity(0.5))
                                        .clipShape(.buttonBorder)
                                        .transition(.scale)
                                }
                            }
                            .animation(.easeOut(duration: 1).delay(1.5), value: animateViewsIn)
                        }
                    }

                    Spacer()
                }
                .frame(width: geo.size.width, height: geo.size.height)
                .foregroundStyle(.white)

                // MARK: Celebration Screen

                if tappedCorrectAnswer {
                    VStack {
                        Spacer()

                        Text("5").font(.largeTitle)
                            .padding(.top, 50)

                        Spacer()

                        Text("Brilliant!")
                            .font(.custom(Constants.hpFont, size: 100))
                        Spacer()

                        Text("Answer 1")
                            .minimumScaleFactor(0.5)
                            .multilineTextAlignment(.center)
                            .padding(10)
                            .frame(width: geo.size.width / 2.15, height: 80)
                            .background(.green.opacity(0.5))
                            .clipShape(.buttonBorder)
                            .scaleEffect(2)

                        Group {
                            Spacer()
                            Spacer()
                        }

                        Button("Next Level>") {
                        }.buttonStyle(.borderedProminent)
                            .tint(.blue.opacity(0.5))
                            .font(.largeTitle)

                        Group {
                            Spacer()
                            Spacer()
                        }
                    }
                    .foregroundStyle(.white)
                }
            }
            .frame(width: geo.size.width, height: geo.size.height)

        }.ignoresSafeArea()
            .onAppear {
                animateViewsIn = true
            }
    }
}

#Preview {
    VStack {
        Gameplay()
    }
}
