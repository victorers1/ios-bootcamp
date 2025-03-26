//
//  SelectCurrency.swift
//  LotRConverter
//
//  Created by Victor Emanuel Ribeiro Silva on 17/03/25.
//

import SwiftUI

struct SelectCurrency: View {
    @Environment(\.dismiss) var dismiss
    @Binding var startingCurrency: Currency
    @Binding var endCurrency: Currency

    var body: some View {
        ZStack {
            // Background Image
            Image(.parchment).resizable().ignoresSafeArea().background(.brown)

            VStack {
                // Text
                Text("Select the currency you are starting with:").fontWeight(.bold)

                // Currency Icons
                CurrencyIconGrid(selectedCurrency: $startingCurrency)

                // Text
                Text("Select the currency you would like to convert to:")
                    .fontWeight(.bold)
                    .padding(.top)

                // Currency Icons
                CurrencyIconGrid(selectedCurrency: $endCurrency)

                // Button
                Button("Done") {
                    dismiss()
                }.buttonStyle(.borderedProminent).tint(
                    .brown.mix(with: .black, by: 0.2)
                ).font(.largeTitle).padding().foregroundStyle(.white)

            }.padding().multilineTextAlignment(.center).foregroundStyle(.black)
        }
    }
}

#Preview {
    @Previewable @State var startingCurrency: Currency = .copperPenny
    @Previewable @State var endCurrency: Currency = .silverPiece

    SelectCurrency(startingCurrency: $startingCurrency, endCurrency: $endCurrency)
}
