//
//  Instructions.swift
//  HP Trivia
//
//  Created by Victor Emanuel Ribeiro Silva on 02/04/25.
//

import SwiftUI

struct Instructions: View {
    @Environment(\.dismiss) private var dismiss

    var body: some View {
        ZStack {
            InfoBackgroundView()

            VStack {
                Image("appiconwithradius")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 150)
                    .padding(.top)

                ScrollView {
                    Text("How To Play")
                        .font(.largeTitle)
                        .padding()

                    VStack(alignment: .leading) {
                        Text(
                            "Welcome to HP Tricia! In this game you will be asked questions from the HP books and you must guss the right answer or you will lose points! 😱"
                        )
                        .padding([.horizontal, .bottom])

                        Text("Each question is worth 5 points, but if you guess a wrong answer, you lose 1 point.")
                            .padding([.horizontal, .bottom])

                        Text("If you are strugling with a questions, there is an options to reveal a hint or reveal the book that answers the question. But beware! Using these also minuses 1 point each.")
                            .padding([.horizontal, .bottom])

                        Text("When you select a correct asnwer, you will be awarded all the points left for that question and they will be added to your total score.")
                            .padding([.horizontal])
                    }.font(.title3)

                    Text("Good Luck")
                        .font(.title)
                }

                .foregroundStyle(.black)

                Button("Done") {
                    dismiss()
                }.doneButton()
            }
        }
    }
}

#Preview {
    Instructions()
}
