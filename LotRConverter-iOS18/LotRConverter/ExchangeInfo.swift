//
//  ExchangeInfo.swift
//  LotRConverter
//
//  Created by Victor Emanuel Ribeiro Silva on 17/03/25.
//

import SwiftUI

struct ExchangeInfo: View {
    @Environment(\.dismiss) var dismiss

    var body: some View {
        ZStack {
            Image(.parchment).resizable().ignoresSafeArea().background(.brown)

            VStack {
                // Title
                Text("Exchange Rates").font(.largeTitle).tracking(3)

                // Instructions
                Text(
                    "Here at the Prancing Pony, we are happy to offer you a place where you can exchange all the known currencies in the entire world except one. We used to take Brandy Bucks, but after finding out that it was a person instead of a piece of paper, we realized it had no value to us. Below is a simple guide to our currency exchange rates:"
                )
                .font(.title3).padding()

                ExchangeRate(
                    leftImage: .goldpiece, rightImage: .goldpenny, text: "1 Gold Piece = 4 Gold Pennies"
                )

                ExchangeRate(
                    leftImage: .goldpenny, rightImage: .silverpiece, text: "1 Gold Penny = 4 Silver Pieces"
                )

                ExchangeRate(
                    leftImage: .silverpiece, rightImage: .silverpenny, text: "1 Silver Piece = 4 Silver Pennies"
                )

                ExchangeRate(
                    leftImage: .silverpenny, rightImage: .copperpenny, text: "1 Silver Penny = 100 Copper Pieces"
                )

                Button("Done") {
                    dismiss()
                }.buttonStyle(.borderedProminent).tint(
                    .brown.mix(with: .black, by: 0.2)
                ).font(.largeTitle).padding().foregroundStyle(.white)

            }.foregroundStyle(.black)
        }
    }
}

#Preview {
    ExchangeInfo()
}
