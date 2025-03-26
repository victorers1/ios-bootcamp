//
//  SelectCurrency.swift
//  LotRConverter
//
//  Created by Victor Emanuel Ribeiro Silva on 17/03/25.
//

import SwiftUI

struct CurrencyIcon: View {
    let currencyImage: ImageResource
    let currencyName: String

    var body: some View {
        ZStack(alignment: .bottom) {
            Image(currencyImage).resizable().scaledToFit()

            Text(currencyName)
                .padding(3)
                .font(.caption)
                .frame(maxWidth: .infinity)
                .background(.brown.opacity(0.75))
        }.padding(3)
            .frame(width: 100, height: 100)
            .background(.brown)
            .clipShape(.rect(cornerRadius: 25))
    }
}

#Preview {
    VStack {
        CurrencyIcon(
            currencyImage: .goldpiece, currencyName: "Gold Piece"
        ).padding()

        CurrencyIcon(
            currencyImage: .silverpiece, currencyName: "Silver Piece"
        ).padding()

        CurrencyIcon(
            currencyImage: .copperpenny, currencyName: "Copper Penny"
        ).padding()

        CurrencyIcon(
            currencyImage: .goldpenny, currencyName: "Gold Penny"
        ).padding()
    }
}
