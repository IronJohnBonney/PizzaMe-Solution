//
//  PhoneCellViewModel.swift
//  PizzaMe
//
//  Copyright © 2016 Charles Schwab & Co., Inc. All rights reserved.
//

import Foundation

class PhoneCellViewModel: DetailCellViewModel {
    let phoneNumber: String
    let imageName: String = "phone_call"
    
    init(restaurant: Restaurant) {
        self.phoneNumber = restaurant.phone
    }
    
    override func getAction() -> String? {
        let digits = phoneNumber.components(separatedBy: NSCharacterSet.decimalDigits.inverted).joined(separator: "")
        return "tel:\(digits)"
    }
}
