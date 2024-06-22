//
//  ContentView.swift
//  LOTRConverter-iOS17
//
//  Created by Mayur Vaity on 22/06/24.
//

import SwiftUI

struct ContentView: View {
    
    @State var showExchangeInfo = false
    
    var body: some View {
        ZStack {
            // background image
            Image(.background)
                .resizable()
                .ignoresSafeArea()
            
            VStack {
                //prancing pony image
                Image(.prancingpony)
                    .resizable()
                    .scaledToFit()
                    .frame(height: 200)
                
                // currency converter text
                Text("Currency Exchange")
                    .font(.largeTitle)
                    .foregroundStyle(.white)
                
                //curreny conversion section
                HStack {
                    //left conversion section
                    VStack {
                        //Currency
                        HStack {
                            //currency image
                            Image(.silverpiece)
                                .resizable()
                                .scaledToFit()
                                .frame(height: 33)
                            
                            //currency text
                            Text("Silver Piece")
                                .font(.headline)
                                .foregroundStyle(.white)
                        }
                        
                        //textfield
                        Text("TextField")
                    }
                    
                    //equal sign
                    Image(systemName: "equal")
                        .font(.largeTitle)
                        .foregroundStyle(.white)
                        .symbolEffect(.pulse)   //to add effect on sfsymbols
                        
                    //right conversion section
                    VStack {
                        //Currency
                        HStack {
                            //currency text
                            Text("Gold Piece")
                                .font(.headline)
                                .foregroundStyle(.white)
                            
                            //currency image
                            Image(.goldpiece)
                                .resizable()
                                .scaledToFit()
                                .frame(height: 33)
                        }
                        
                        //textfield
                        Text("TextField")
                    }
                }
                
                Spacer()
                
                //info button
                HStack {
                    Spacer()
                    
                    Button(action: {
                        print("info button tapped")
                        showExchangeInfo.toggle()
                        
                    }, label: {
                        Image(systemName: "info.circle.fill")
                            .font(.largeTitle)
                            .foregroundStyle(.white)
                    })
                    .padding(.trailing, 20)
                    
                }
            }
//            .border(.blue)
        }
    }
}

#Preview {
    ContentView()
}
