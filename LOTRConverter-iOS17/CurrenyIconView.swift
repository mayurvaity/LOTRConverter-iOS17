//
//  CurrenyIconView.swift
//  LOTRConverter-iOS17
//
//  Created by Mayur Vaity on 23/06/24.
//

import SwiftUI

struct CurrenyIconView: View {
    
    let currencyImage: ImageResource
    let currencyText: String
    
    var body: some View {
        //alignment - alignment of views added should be bottom (default is center)
        ZStack(alignment: .bottom) {
            //Currency Image
            Image(currencyImage)
                .resizable()
                .scaledToFit()
                
            //currency name
            Text(currencyText)
                .padding(3)
                .font(.caption)
                .frame(maxWidth: .infinity)     //.infinity - stretch to edges of ur parent view
                .background(.brown.opacity(0.75))
            
        }
        .padding(3)
        .frame(width: /*@START_MENU_TOKEN@*/100/*@END_MENU_TOKEN@*/, height: 100)
        .background(.brown)
        .clipShape(.rect(cornerRadius: 25))
    }
}

#Preview {
    CurrenyIconView(currencyImage: .copperpenny,
                    currencyText: "Copper Penny")
}
