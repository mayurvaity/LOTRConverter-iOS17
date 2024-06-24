//
//  ContentView.swift
//  LOTRConverter-iOS17
//
//  Created by Mayur Vaity on 22/06/24.
//

import SwiftUI

struct ContentView: View {
    
    @State var showExchangeInfo = false
    @State var showSelectCurrency = false
    
    @State var leftAmount = ""
    @State var rightAmount = ""
    
    @State var leftCurrency: Currency = .silverPiece
    @State var rightCurrency: Currency = .goldPiece
    
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
                            Image(leftCurrency.image)
                                .resizable()
                                .scaledToFit()
                                .frame(height: 33)
                            
                            //currency text
                            Text(leftCurrency.name)
                                .font(.headline)
                                .foregroundStyle(.white)
                        }
                        .padding(.bottom, -5)
                        .onTapGesture {
                            showSelectCurrency.toggle()
                        }
                        
                        //textfield
                        TextField("Amount", text: $leftAmount)
                            .textFieldStyle(.roundedBorder)
                        
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
                            Text(rightCurrency.name)
                                .font(.headline)
                                .foregroundStyle(.white)
                            
                            //currency image
                            Image(rightCurrency.image)
                                .resizable()
                                .scaledToFit()
                                .frame(height: 33)
                        }
                        .padding(.bottom, -5) //negative padding to bring views closer
                        .onTapGesture {
                            showSelectCurrency.toggle()
                        }
                        
                        //textfield
                        //multilineTextAlignment - to align placeholder text to right
                        TextField("Amount", text: $rightAmount)
                            .textFieldStyle(.roundedBorder)
                            .multilineTextAlignment(.trailing)
                        
                    }
                }
                .padding()
                .background(.black.opacity(0.5))
                .clipShape(.capsule)
                
                Spacer()
                
                //info button
                HStack {
                    Spacer()
                    
                    Button(action: {
                        print("info button tapped")
//                        print("showExchangeInfo b4 btn tap: \(showExchangeInfo)")
                        showExchangeInfo.toggle()
//                        print("showExchangeInfo after btn tap: \(showExchangeInfo)")
                        
                    }, label: {
                        //frame - it determines touch target area
                        Image(systemName: "info.circle.fill")
                            .font(.largeTitle)
                            .foregroundStyle(.white)
                            .frame(width: 50, height: 50)
                    })
                    .padding(.trailing, 20)
                    
                }
            }
            
//            .border(.blue)
        }
        //sheet - to call Modal view when button is pressed, this works when value of variable passed to isPresented parameter (in this case, $showExchangeInfo) is changed, that's why it takes a binding variable (to monitor for changes to that variable)
        .sheet(isPresented: $showExchangeInfo, content: {
            //exchange info view called, in Modal way
            ExchangeInfoView()
        })
        .sheet(isPresented: $showSelectCurrency, content: {
            SelectCurrencyView(topCurrency: $leftCurrency,
                               bottomCurrency: $rightCurrency)
        })
        .onAppear {
//            print("showExchangeInfo onAppear: \(showExchangeInfo)")
        }
        
    }
}

#Preview {
    ContentView()
}
