//
//  OverviewCellViewModel.swift
//  PizzaMe
//
//  Copyright © 2016 Charles Schwab & Co., Inc. All rights reserved.
//

import Foundation

class OverviewCellViewModel : DetailCellViewModel {
    let name: String
    let distance: String
    
    init(restaurant: Restaurant) {
        self.name = restaurant.name
        self.distance = "\(restaurant.distance) mile(s)"
    }
}
