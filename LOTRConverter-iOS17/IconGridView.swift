//
//  IconGridView.swift
//  LOTRConverter-iOS17
//
//  Created by Mayur Vaity on 23/06/24.
//

import SwiftUI

struct IconGridView: View {
    
    //to store selected currency
    @Binding var currency: Currency
    
    var body: some View {
       
        //columns - to set no of griditems there will be in a single row
        LazyVGrid(columns: [GridItem(), GridItem(), GridItem()]) {
            //Currency.allCases - it returns all cases of enum as an array
            ForEach(Currency.allCases) { currency in
                if self.currency == currency {
                    CurrenyIconView(currencyImage: currency.image,
                                    currencyText: currency.name)
                    .shadow(color: .black, radius: /*@START_MENU_TOKEN@*/10/*@END_MENU_TOKEN@*/)
                    .overlay {
                        //below code to put dark border around it
                        //stroke -for border
                        //opacity -for transparency
                        RoundedRectangle(cornerRadius: 25)
                            .stroke(lineWidth: 3)
                            .opacity(0.5)
                    }
                } else {
                    CurrenyIconView(currencyImage: currency.image,
                                    currencyText: currency.name)
                    .onTapGesture {
                        //to select a currency
                        self.currency = currency
                    }
                }
            }
        }
        
    }
}

#Preview {
    IconGridView(currency: .constant(.copperPenny)) 
}
