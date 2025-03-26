//
//  SelectCurrency.swift
//  LotRConverter
//
//  Created by Victor Emanuel Ribeiro Silva on 17/03/25.
//

import SwiftUI

struct CurrencyIconGrid: View {
    @Binding var selectedCurrency: Currency

    var body: some View {
        LazyVGrid(columns: [GridItem(), GridItem(), GridItem()]) {
            ForEach(Currency.allCases) { currency in

                if currency == selectedCurrency {
                    CurrencyIcon(
                        currencyImage: currency.image,
                        currencyName: currency.name
                    ).shadow(color: .black, radius: 10).overlay {
                        RoundedRectangle(cornerRadius: 25)
                            .stroke(lineWidth: 3).opacity(0.5)
                    }
                } else {
                    CurrencyIcon(
                        currencyImage: currency.image,
                        currencyName: currency.name
                    ).onTapGesture {
                        selectedCurrency = currency
                    }
                }
            }
        }
    }
}

#Preview {
    @Previewable @State var selectedCurrency: Currency = .copperPenny
    CurrencyIconGrid(selectedCurrency: $selectedCurrency)
}
