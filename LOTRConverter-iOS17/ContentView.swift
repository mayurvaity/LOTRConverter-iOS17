//
//  ContentView.swift
//  LOTRConverter-iOS17
//
//  Created by Mayur Vaity on 22/06/24.
//

import SwiftUI
import TipKit

struct ContentView: View {
    
    //storing left and right currency data in userDefaults
    @AppStorage("leftCurrencyData") private var leftCurrencyData: Data?
    @AppStorage("rightCurrencyData") private var rightCurrencyData: Data?
    
    @State var showExchangeInfo = false
    @State var showSelectCurrency = false
    
    @State var leftAmount = ""
    @State var rightAmount = ""
    
    //variables to store state of textfields which is in focus
    @FocusState var leftTyping
    @FocusState var rightTyping
    
    @State var leftCurrency: Currency = .copperPenny
    @State var rightCurrency: Currency = .copperPenny
    
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
        .onTapGesture {
            //on tapping anywhere on the ztack, keyboard will be dismissed using below fn
            hideKeyboard()
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
            //calling below fn to save selected currency data once currency is changed
            saveChanges()
        })
        .onChange(of: rightCurrency, {
            rightAmount = leftCurrency.convert(leftAmount,
                                               to: rightCurrency)
            //calling below fn to save selected currency data once currency is changed
            saveChanges()
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
            //all below code run right when app loads
            //to call and get currency data from userDefaults
            retrieveCurrencyData()
//            print("showExchangeInfo onAppear: \(showExchangeInfo)")
        }
        
    }
    
    //fn to save currency data in user defaults
    func saveChanges() {
        //encoding data into type Data and storing it into userdefaults
        do {
            //encoding objs leftCurrency & rightCurrency and storing them in vars named leftCdata & rightCdata
            let leftCdata = try JSONEncoder().encode(leftCurrency)
            let rightCdata = try JSONEncoder().encode(rightCurrency)
            //assigning these to @AppStorage objs named leftCurrencyData & rightCurrencyData to store into userdefaults
            leftCurrencyData = leftCdata
            rightCurrencyData = rightCdata
            print("changes saved.")
        } catch {
            print("Error saving currency data to userDefaults, \(error)")
        }
        
    }
    
    //fn to extract data from user defaults
    func retrieveCurrencyData() {
        //checking if @AppStorage obj named "leftCurrencyData" and "rightCurrencyData" has any value, otherwise skipping further actions, as there is no data saved
        guard let leftCurrencyData else { return }
        guard let rightCurrencyData else { return }
        
        do {
            //to get data from userdefaults and store it into obj named "leftCurrency" and "rightCurrency"
            leftCurrency = try JSONDecoder().decode(Currency.self, from: leftCurrencyData)
            rightCurrency = try JSONDecoder().decode(Currency.self, from: rightCurrencyData)
            print("Got the data from userDefaults.")
        } catch {
            print("Error retrieving left and/or right currency data, \(error)")
        }
    }
    
    //fn to dismiss keyboard
    func hideKeyboard() {
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
    
}



#Preview {
    ContentView()
}
