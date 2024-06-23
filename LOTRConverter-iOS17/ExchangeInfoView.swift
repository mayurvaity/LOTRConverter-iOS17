//
//  ExchangeInfoView.swift
//  LOTRConverter-iOS17
//
//  Created by Mayur Vaity on 22/06/24.
//

import SwiftUI

struct ExchangeInfoView: View {
    var body: some View {
        ZStack {
            //background parchment image
            Image(.parchment)
                .resizable()
                .ignoresSafeArea()
                .background(.brown)
            
            VStack {
                //title text
                //tracking - to add spacing between letters
                Text("Exchange Rates")
                    .font(.largeTitle)
                    .tracking(3)
                
                //Description text
                Text("Here at the Prancing Pony, we are happy to offer you a place where you can exchange all the known currencies in the entire world except one. We used to take Brandy Bucks, but after finding out that it was a person instead of a piece of paper, we realized it had no value to us. Below is a simple guide to our currency exchange rates:")
                    .font(.title2)
                    .padding()
                
                //Exchange rates
                ExchangeRatesView(leftImage: .goldpiece,
                                  exchangeRateText: "1 Gold Piece = 4 Gold Pennies",
                                  rightImage: .goldpenny)
                
                ExchangeRatesView(leftImage: .goldpenny,
                                  exchangeRateText: "1 Gold Penny = 4 Silver Pieces",
                                  rightImage: .silverpiece)
                
                ExchangeRatesView(leftImage: .silverpiece,
                                  exchangeRateText: "1 Silver Piece = 4 Silver Pennies",
                                  rightImage: .silverpenny)
                
                ExchangeRatesView(leftImage: .silverpenny,
                                  exchangeRateText: "1 Silver Penny = 100 Copper Pennies",
                                  rightImage: .copperpenny)
                
                //done button
                Button("Done") {
                    
                }
                .buttonStyle(.borderedProminent)
                .tint(.brown)
                .font(.largeTitle)
                .padding()
                .foregroundStyle(.white)
                
            }
            .foregroundStyle(.black)
            
        }
    }
}

#Preview {
    ExchangeInfoView()
}
