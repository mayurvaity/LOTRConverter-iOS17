//
//  Currency.swift
//  LOTRConverter-iOS17
//
//  Created by Mayur Vaity on 23/06/24.
//

import Foundation
import SwiftUI

//CaseIterable - converts our enum into Array type (can be used as an collection)
//Identifiable - to add unique identifier to identify each element in the collection
enum Currency: Double, CaseIterable, Identifiable {
    case copperPenny = 6400
    case silverPenny = 64
    case silverPiece = 16
    case goldPenny = 4
    case goldPiece = 1
    
    //as all values in an enum are unique, we can assign those to id, to be able to uniquly identify each element 
    var id: Currency { self }
    
    var image: ImageResource {
        switch self {
        case .copperPenny:
                .copperpenny
        case .silverPenny:
                .silverpenny
        case .silverPiece:
                .silverpiece
        case .goldPenny:
                .goldpenny
        case .goldPiece:
                .goldpiece
        }
    }
    
    var name: String {
        switch self {
        case .copperPenny:
            "Copper Penny"
        case .silverPenny:
            "Silver Penny"
        case .silverPiece:
            "Silver Piece"
        case .goldPenny:
            "Gold Penny"
        case .goldPiece:
            "Gold Piece"
        }
    }
    
    //fn to convert amount from one currency to another
    //current currency would be of the field in which amount was entered
    func convert(_ amountString: String, to currency: Currency) -> String {
        //checking if we get only double values in the string
        guard let doubleAmount = Double(amountString) else {
            return ""
        }
        
        //logic to convert amount from one currency to other
        let convertedAmount = (doubleAmount / self.rawValue) * currency.rawValue
        
        //to foramt double to string, also specifying that string has only 2 digits after decimal point
        return String(format: "%.2f", convertedAmount) 
    }
}
