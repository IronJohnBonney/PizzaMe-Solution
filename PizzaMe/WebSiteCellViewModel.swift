//
//  WebSiteCellViewModel.swift
//  PizzaMe
//
//  Copyright © 2016 Charles Schwab & Co., Inc. All rights reserved.
//

import Foundation

class WebSiteCellViewModel: DetailCellViewModel {
    let webSite: String
    let imageName: String = "icon-website"
    
    init(restaurant: Restaurant) {
        self.webSite = restaurant.businessUrl
    }
    
    override func getAction() -> String? {
        return webSite
    }
}
