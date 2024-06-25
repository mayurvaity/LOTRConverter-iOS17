//
//  CurrencyTip.swift
//  LOTRConverter-iOS17
//
//  Created by Mayur Vaity on 25/06/24.
//

import Foundation
import TipKit

struct CurrencyTip: Tip {
    var title = Text("Change Currency")
    
    var message: Text? = Text("You can tap the left or right currency to bring up the Select Currency screen.")
}
