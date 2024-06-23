//
//  ExchangeRatesView.swift
//  LOTRConverter-iOS17
//
//  Created by Mayur Vaity on 22/06/24.
//

import SwiftUI

struct ExchangeRatesView: View {
    
    let leftImage: ImageResource
    let exchangeRateText: String
    let rightImage: ImageResource
    
    
    var body: some View {
        HStack {
            //left currency image
            Image(leftImage)
                .resizable()
                .scaledToFit()
                .frame(height: 33)
            
            // Exchange rate text
            Text(exchangeRateText)
            
            //right currency image
            Image(rightImage)
                .resizable()
                .scaledToFit()
                .frame(height: 33)
            
        }
    }
}

#Preview {
    ExchangeRatesView(leftImage: .goldpiece, exchangeRateText: "1 Gold Piece = 4 Gold Pennies", rightImage: .goldpenny)
}
