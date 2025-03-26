//
//  ContentView.swift
//  LotRConverter
//
//  Created by Victor Emanuel Ribeiro Silva on 17/03/25.
//

import SwiftUI
import TipKit

struct ContentView: View {
    @State var showExchangeInfo = false
    @State var showSelectCurrencies = false

    @State var leftAmount: String = ""
    @State var rightAmount: String = ""

    @State var leftCurrency: Currency = .silverPiece
    @State var rightCurrency: Currency = .goldPiece

    @FocusState var leftTyping: Bool
    @FocusState var rightTyping: Bool
    
    let currencyTip = CurrencyTip()

    var body: some View {
        ZStack {
            Image(.background).resizable().ignoresSafeArea()

            VStack {
                Image(.prancingpony).resizable().scaledToFit().frame(
                    height: 200)

                Text("Currency Exchange").font(.largeTitle).foregroundStyle(
                    .white)

                // Convertion Section
                HStack {
                    // Left conversion section
                    VStack {
                        HStack {
                            // Currency image
                            Image(leftCurrency.image)
                                .resizable()
                                .scaledToFit()
                                .frame(height: 33)

                            // Currency text
                            Text(leftCurrency.name).font(.headline)
                                .foregroundStyle(.white)
                        }.onTapGesture {
                            showSelectCurrencies.toggle()
                            currencyTip.invalidate(reason: .actionPerformed)
                        }.popoverTip(currencyTip, arrowEdge: .bottom)

                        TextField("Amount", text: $leftAmount)
                            .textFieldStyle(.roundedBorder)
                            .focused($leftTyping)
                    }

                    // Equals sign
                    Image(systemName: "equal").font(.largeTitle)
                        .foregroundStyle(.white).symbolEffect(.pulse)

                    // Right conversion input
                    VStack {
                        HStack {
                            // Currency text
                            Text(rightCurrency.name)
                                .font(.headline)
                                .foregroundStyle(
                                    .white)

                            // Currency image
                            Image(rightCurrency.image)
                                .resizable()
                                .scaledToFit()
                                .frame(
                                    height: 33)
                        }.onTapGesture {
                            showSelectCurrencies.toggle()
                        }

                        TextField("Amount", text: $rightAmount)
                            .textFieldStyle(.roundedBorder)
                            .multilineTextAlignment(.trailing)
                            .focused($rightTyping)
                    }
                }.padding().background(.black.opacity(0.5)).clipShape(.capsule).keyboardType(.decimalPad)

                Spacer()

                // Info button
                HStack {
                    Spacer()

                    Button {
                        showExchangeInfo.toggle()
                    } label: {
                        Image(systemName: "info.circle.fill")
                            .font(.largeTitle)
                            .foregroundStyle(.white)
                    }
                }
            }.padding()
        }
        .task {
            try? Tips.configure()
        }
        .onChange(of: leftAmount) {
            if leftTyping {
                rightAmount = leftCurrency.convert(leftAmount, to: rightCurrency)
            }
        }
        .onChange(of: rightAmount) {
            if rightTyping {
                leftAmount = rightCurrency.convert(rightAmount, to: leftCurrency)
            }
        }
        .onChange(of: leftCurrency) {
            leftAmount = rightCurrency.convert(rightAmount, to: leftCurrency)
        }
        .onChange(of: rightCurrency) {
            rightAmount = leftCurrency.convert(leftAmount, to: rightCurrency)
        }
        .sheet(isPresented: $showExchangeInfo) {
            ExchangeInfo()
        }.sheet(isPresented: $showSelectCurrencies) {
            SelectCurrency(
                startingCurrency: $leftCurrency,
                endCurrency: $rightCurrency
            )
        }
    }
}

#Preview {
    ContentView()
}
