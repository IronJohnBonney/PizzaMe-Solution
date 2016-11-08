//
//  RestaurantListViewModelTest.swift
//  PizzaMe
//
//  Copyright © 2016 Charles Schwab & Co., Inc. All rights reserved.
//

import XCTest
@testable import PizzaMe

class RestaurantListViewModelTest: XCTestCase {
    var viewModel: RestaurantListViewModel?
       
    let jsonData = "{\"query\":{\"count\":10,\"created\":\"2016-07-28T03:24:38Z\",\"lang\":\"en-US\",\"results\":{\"Result\":[{\"id\":\"191218595\",\"xmlns\":\"urn:yahoo:lcl\",\"Title\":\"Flaming Pizza\",\"Address\":\"3220 Feathergrass Ct, Ste 140\",\"City\":\"Austin\",\"State\":\"TX\",\"Phone\":\"(512) 792-9595\",\"Latitude\":\"30.395\",\"Longitude\":\"-97.72735\",\"Rating\":{\"AverageRating\":\"NaN\",\"TotalRatings\":\"0\",\"TotalReviews\":\"0\",\"LastReviewDate\":null,\"LastReviewIntro\":null},\"Distance\":\"1.39\",\"Url\":\"https://local.yahoo.com/info-191218595-flaming-pizza-austin\",\"ClickUrl\":\"https://local.yahoo.com/info-191218595-flaming-pizza-austin\",\"MapUrl\":\"https://local.yahoo.com/info-191218595-flaming-pizza-austin?viewtype=map\",\"BusinessUrl\":\"http://www.flamingpizzausa.com/\",\"BusinessClickUrl\":\"http://www.flamingpizzausa.com/\",\"Categories\":{\"Category\":{\"id\":\"96926243\",\"content\":\"Pizza\"}}}]}}}".data(using: String.Encoding.utf8)
    
    
    override func setUp() {
        let json = try? JSONSerialization.jsonObject(with: jsonData!, options: .allowFragments)
        let response = SearchServiceResponse(response: json as? [String:AnyObject])
        if let response = response {
            viewModel = RestaurantListViewModel(restaurantList: response.restaurantList)
        }
    }
}

extension RestaurantListViewModelTest {
    func testRestaurantListCountInit() {
        XCTAssertNotNil(viewModel)
        if let viewModel = viewModel {
            XCTAssertEqual(viewModel.restaurantCount, 1)
        }
    }
    
    func testRestaurantListForInvalidIndex() {
        XCTAssertNotNil(viewModel)
        if let viewModel = viewModel {
            let indexPath = IndexPath(item: 1, section: 0)
            XCTAssertNil(viewModel.restaurant(indexPath: indexPath))
        }
    }
    
    func testRestaurantListForValidIndex() {
        XCTAssertNotNil(viewModel)
        if let viewModel = viewModel {
            let indexPath = IndexPath(item: 0, section: 0)
            XCTAssertNotNil(viewModel.restaurant(indexPath: indexPath))
        }

    }
}
