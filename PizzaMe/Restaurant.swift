//
//  Restaurant.swift
//  PizzaMe
//
//  Copyright © 2016 Charles Schwab & Co., Inc. All rights reserved.
//

import Foundation
import CoreLocation

enum RestaurantKey : String {
    case title = "Title"
    case address = "Address"
    case city = "City"
    case state = "State"
    case phone = "Phone"
    case distance = "Distance"
    case businessUrl = "BusinessUrl"
    case latitude = "Latitude"
    case longitude = "Longitude"
}

struct Restaurant {
    let name: String
    let address: String
    let city: String
    let state: String
    let phone: String
    let distance: Double
    let businessUrl: String
    let latitude: Double
    let longitude: Double
    
    init?(restaurant:[String: AnyObject]) {
        guard let name = restaurant[RestaurantKey.title.rawValue] as? String,
            let address = restaurant[RestaurantKey.address.rawValue] as? String,
            let city = restaurant[RestaurantKey.city.rawValue] as? String,
            let state = restaurant[RestaurantKey.state.rawValue] as? String,
            let phone = restaurant[RestaurantKey.phone.rawValue] as? String,
            let distanceString = restaurant[RestaurantKey.distance.rawValue] as? String,
            let businessUrl = restaurant[RestaurantKey.businessUrl.rawValue] as? String,
            let latitudeString = restaurant[RestaurantKey.latitude.rawValue] as? String,
            let longitudeString = restaurant[RestaurantKey.longitude.rawValue] as? String,
            let latitude = Double(longitudeString),
            let longitude = Double(latitudeString),
            let distance = Double(distanceString) else {
                return nil
        }
        self.name = name
        self.address = address
        self.city = city
        self.state = state
        self.phone = phone
        self.distance = distance
        self.businessUrl = businessUrl
        self.latitude = latitude
        self.longitude = longitude
    }
}
