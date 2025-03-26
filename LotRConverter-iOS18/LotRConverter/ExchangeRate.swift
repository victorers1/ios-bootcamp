//
//  ExchangeRate.swift
//  LotRConverter
//
//  Created by Victor Emanuel Ribeiro Silva on 17/03/25.
//

import SwiftUI

struct ExchangeRate: View {
    let leftImage: ImageResource
    let rightImage: ImageResource
    let text: String

    var body: some View {
        HStack {
            Image(leftImage).resizable().scaledToFit().frame(height: 33)

            Text(text)

            Image(rightImage).resizable().scaledToFit().frame(height: 33)
        }
    }
}

#Preview {
    VStack {
        ExchangeRate(leftImage: .goldpiece, rightImage: .goldpenny, text: "1 Gold piece = 4 Gold Pennies")
        ExchangeRate(
            leftImage: .silverpiece,
            rightImage: .silverpenny,
            text: "1 Gold piece = 4 Gold Pennies"
        )
        ExchangeRate(
            leftImage: .copperpenny,
            rightImage: .copperpenny,
            text: "1 Gold piece = 4 Gold Pennies"
        )
    }
}
