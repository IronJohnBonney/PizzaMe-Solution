//
//  DetailViewModelTest.swift
//  PizzaMe
//
//  Copyright © 2016 Charles Schwab & Co., Inc. All rights reserved.
//

import XCTest
@testable import PizzaMe

class DetailViewModelTest: XCTestCase {
    var viewModel: DetailViewModel?
    
    let jsonData = "{\"query\":{\"count\":10,\"created\":\"2016-07-28T03:24:38Z\",\"lang\":\"en-US\",\"results\":{\"Result\":[{\"id\":\"191218595\",\"xmlns\":\"urn:yahoo:lcl\",\"Title\":\"Flaming Pizza\",\"Address\":\"3220 Feathergrass Ct, Ste 140\",\"City\":\"Austin\",\"State\":\"TX\",\"Phone\":\"(512) 792-9595\",\"Latitude\":\"30.395\",\"Longitude\":\"-97.72735\",\"Rating\":{\"AverageRating\":\"NaN\",\"TotalRatings\":\"0\",\"TotalReviews\":\"0\",\"LastReviewDate\":null,\"LastReviewIntro\":null},\"Distance\":\"1.39\",\"Url\":\"https://local.yahoo.com/info-191218595-flaming-pizza-austin\",\"ClickUrl\":\"https://local.yahoo.com/info-191218595-flaming-pizza-austin\",\"MapUrl\":\"https://local.yahoo.com/info-191218595-flaming-pizza-austin?viewtype=map\",\"BusinessUrl\":\"http://www.flamingpizzausa.com/\",\"BusinessClickUrl\":\"http://www.flamingpizzausa.com/\",\"Categories\":{\"Category\":{\"id\":\"96926243\",\"content\":\"Pizza\"}}}]}}}".data(using: String.Encoding.utf8)
    
    
    override func setUp() {
        let json = try? JSONSerialization.jsonObject(with: jsonData!, options: .allowFragments)
        let response = SearchServiceResponse(response: json as? [String:AnyObject])
        if let response = response {
            viewModel = DetailViewModel(restaurant: response.restaurantList[0])
        }
    }
}

extension DetailViewModelTest {
    func testDetailViewModelInit() {
        XCTAssertNotNil(viewModel)
    }
    
    func testViewModelForInvalidCell() {
        XCTAssertNotNil(viewModel)
        if let viewModel = viewModel {
            let invalidIndexPath = IndexPath(item: viewModel.availableCells.count+1, section: 0)
            XCTAssertNil(viewModel.cellViewModelFor(indexPath: invalidIndexPath))
        }
    }
    
    func testViewModelForOverviewCell() {
        XCTAssertNotNil(viewModel)
        if let viewModel = viewModel {
            let overviewRow: Int = DetailCellType.overview.rawValue
            
            let overviewIndexPath = IndexPath(item: overviewRow, section: 0)
            let detailCellViewModel = viewModel.cellViewModelFor(indexPath: overviewIndexPath)
            XCTAssertNotNil(detailCellViewModel)
            XCTAssert(detailCellViewModel is OverviewCellViewModel)
        }
    }
    
    func testViewModelForDirectionsCell() {
        XCTAssertNotNil(viewModel)
        if let viewModel = viewModel {
            let row: Int = DetailCellType.directions.rawValue
            
            let indexPath = IndexPath(item: row, section: 0)
            let detailCellViewModel = viewModel.cellViewModelFor(indexPath: indexPath)
            XCTAssertNotNil(detailCellViewModel)
            XCTAssert(detailCellViewModel is DirectionsCellViewModel)
        }
    }

    func testViewModelForPhoneCell() {
        XCTAssertNotNil(viewModel)
        if let viewModel = viewModel {
            let row: Int = DetailCellType.phone.rawValue
            
            let indexPath = IndexPath(item: row, section: 0)
            let detailCellViewModel = viewModel.cellViewModelFor(indexPath: indexPath)
            XCTAssertNotNil(detailCellViewModel)
            XCTAssert(detailCellViewModel is PhoneCellViewModel)
        }
    }
    
    func testViewModelForWebSiteCell() {
        XCTAssertNotNil(viewModel)
        if let viewModel = viewModel {
            let row: Int = DetailCellType.website.rawValue
            
            let indexPath = IndexPath(item: row, section: 0)
            let detailCellViewModel = viewModel.cellViewModelFor(indexPath: indexPath)
            XCTAssertNotNil(detailCellViewModel)
            XCTAssert(detailCellViewModel is WebSiteCellViewModel)
        }
    }

    func testViewModelForWebAddressCell() {
        XCTAssertNotNil(viewModel)
        if let viewModel = viewModel {
            let row: Int = DetailCellType.address.rawValue
            
            let indexPath = IndexPath(item: row, section: 0)
            let detailCellViewModel = viewModel.cellViewModelFor(indexPath: indexPath)
            XCTAssertNotNil(detailCellViewModel)
            XCTAssert(detailCellViewModel is AddressCellViewModel)
        }
    }

}
