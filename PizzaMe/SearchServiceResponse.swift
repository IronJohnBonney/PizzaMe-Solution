//
//  SearchServiceResponse.swift
//  PizzaMe
//
//  Copyright © 2016 Charles Schwab & Co., Inc. All rights reserved.
//

import Foundation

enum ResponseKeys: String {
    case query      = "query"
    case results    = "results"
    case result     = "Result"
}

class SearchServiceResponse {
    var restaurantList: Array<Restaurant> = Array()
    
    init?(response: [String:AnyObject]?) {
        guard let response = response,
            let query=response[ResponseKeys.query.rawValue],
            let results = (query[ResponseKeys.results.rawValue] as? [String:AnyObject]),
            let result = (results[ResponseKeys.result.rawValue] as? [[String:AnyObject]])  else {
            return nil
        }
        for restaurantData in result {
            if let restaurant = Restaurant(restaurant: restaurantData) {
                restaurantList.append(restaurant)
            }
        }
    }
}
