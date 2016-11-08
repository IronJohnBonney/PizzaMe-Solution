//
//  AddressCellViewModel.swift
//  PizzaMe
//
//  Copyright © 2016 Charles Schwab & Co., Inc. All rights reserved.
//

import Foundation

class AddressCellViewModel: DetailCellViewModel {
    let address: String
    let cityState: String
    let imageName: String = "address-image"
    let longitude: Double
    let latitude: Double
    
    init(restaurant: Restaurant) {
        self.address = restaurant.address
        self.cityState = restaurant.city + ", " + restaurant.state
        self.longitude = restaurant.longitude
        self.latitude = restaurant.latitude
    }
    
    override func getAction() -> String? {
        return "http://maps.apple.com/?ll=\(self.latitude),\(self.longitude)"
    }
}
