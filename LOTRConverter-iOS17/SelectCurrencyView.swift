//
//  SelectCurrencyView.swift
//  LOTRConverter-iOS17
//
//  Created by Mayur Vaity on 23/06/24.
//

import SwiftUI

struct SelectCurrencyView: View {
    
    @Environment(\.dismiss) var dismiss
    @Binding var topCurrency: Currency
    @Binding var bottomCurrency: Currency
    
    var body: some View {
        ZStack {
            //parchment image
            Image(.parchment)
                .resizable()
                .ignoresSafeArea()
                .background(.brown)
            
            VStack {
                //Text
                Text("Select the currency you are staring with:")
                    .fontWeight(.bold)
                    
                //curreny icons
                IconGridView(currency: $topCurrency)
                
                //Text
                Text("Select the currency you would like to convert to:")
                    .fontWeight(.bold)
                    
                
                //curreny icons
                IconGridView(currency: $bottomCurrency)
                
                //Done button
                Button("Done") {
                    //to dismiss modal view
                    //this also sets variable passed as parameter to isPresented ($showExchangeInfo) to false
                    dismiss()
                }
                .buttonStyle(.borderedProminent)
                .tint(.brown)
                .font(.largeTitle)
                .padding()
                .foregroundStyle(.white)
                
            }
            .padding()
            .multilineTextAlignment(.center)
        }
    }
}

#Preview {
    SelectCurrencyView(topCurrency: .constant(.silverPenny), bottomCurrency: .constant(.goldPiece))
}
