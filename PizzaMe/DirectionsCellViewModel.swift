//
//  DirectionsCellViewModel.swift
//  PizzaMe
//
//  Copyright © 2016 Charles Schwab & Co., Inc. All rights reserved.
//

import Foundation

class DirectionsCellViewModel: DetailCellViewModel {
    let address: String
    let city: String
    let state: String
    let imageName: String = "map-icon"
    
    init(restaurant: Restaurant) {
        self.address = restaurant.address
        self.city = restaurant.city
        self.state = restaurant.state
    }
    
    override func getAction() -> String? {
        let destinationAddress = "\(self.address),\(self.city),\(self.state)".components(separatedBy: NSCharacterSet.whitespacesAndNewlines).joined(separator: "+")
        return "http://maps.apple.com/?daddr=\(destinationAddress)"
    }
    
}
