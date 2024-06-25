//
//  ContentView.swift
//  LOTRConverter-iOS17
//
//  Created by Mayur Vaity on 22/06/24.
//

import SwiftUI
import TipKit

struct ContentView: View {
    
    @State var showExchangeInfo = false
    @State var showSelectCurrency = false
    
    @State var leftAmount = ""
    @State var rightAmount = ""
    
    //variables to store state of textfields which is in focus
    @FocusState var leftTyping
    @FocusState var rightTyping
    
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
                        //popoverTip - to see tip on left currency
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
                        .popoverTip(CurrencyTip(),
                                    arrowEdge: .bottom)
                        
                        //textfield
                        //focused - to observ if this TextField is being focused upon (being edited) and changes value of FocusState var
                        //keyboardType - to specify type of keyboard that will pop-up when tapped on this field - decimalpad - to show only numbers and decimal pt
                        TextField("Amount", text: $leftAmount)
                            .textFieldStyle(.roundedBorder)
                            .focused($leftTyping)
                            .keyboardType(.decimalPad)
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
                        //focused - to observ if this TextField is being focused upon (being edited) and changes value of FocusState var
                        //keyboardType - to specify type of keyboard that will pop-up when tapped on this field - decimalpad - to show only numbers and decimal pt
                        TextField("Amount", text: $rightAmount)
                            .textFieldStyle(.roundedBorder)
                            .multilineTextAlignment(.trailing)
                            .focused($rightTyping)
                            .keyboardType(.decimalPad)
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
        //task - the code in this modifier run right when app is loaded
        .task {
            //to show all tips when app starts (only when app is freshly installed) 
            try? Tips.configure()
        }
        //onChange - to observ for change in leftTextField and convert to right currency, and then update it in right text field
        .onChange(of: leftAmount) {
            if leftTyping {
                rightAmount = leftCurrency.convert(leftAmount,
                                                   to: rightCurrency)
            }
        }
        .onChange(of: rightAmount) {
            if rightTyping {
                leftAmount = rightCurrency.convert(rightAmount,
                                                   to: leftCurrency)
            }
        }
        //below 2 run when select a currency view is called and a new currency is selected
        .onChange(of: leftCurrency, {
            leftAmount = rightCurrency.convert(rightAmount,
                                               to: leftCurrency)
        })
        .onChange(of: rightCurrency, {
            rightAmount = leftCurrency.convert(leftAmount,
                                               to: rightCurrency)
        })
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
