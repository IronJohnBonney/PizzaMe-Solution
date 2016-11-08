//
//  DetailViewModel.swift
//  PizzaMe
//
//  Copyright © 2016 Charles Schwab & Co., Inc. All rights reserved.
//

import Foundation

enum DetailCellType : Int {
    case overview
    case directions
    case phone
    case website
    case address
    
    var cellIdentifier : String {
        switch (self) {
        case .overview:
            return "OverviewCell"
        case .directions:
            return "DirectionsCell"
        case .phone:
            return "PhoneCell"
        case .website:
            return "WebSiteCell"
        case .address:
            return "AddressCell"
        }
    }
}

class DetailViewModel {
    let title: String
    let availableCells:[DetailCellType] = [.overview, .directions, .phone, .website, .address]
    let restaurant: Restaurant
    
    init(restaurant: Restaurant) {
        self.restaurant = restaurant
        self.title = "Details"
    }
    
    func cellViewModelFor(indexPath: IndexPath) -> DetailCellViewModel? {
        var viewModel:DetailCellViewModel? = nil
        
        if indexPath.row == DetailCellType.overview.rawValue {
            viewModel = OverviewCellViewModel(restaurant: restaurant)
        } else if indexPath.row == DetailCellType.phone.rawValue {
            viewModel = PhoneCellViewModel(restaurant: restaurant)
        } else if indexPath.row == DetailCellType.website.rawValue {
            viewModel = WebSiteCellViewModel(restaurant: restaurant)
        } else if indexPath.row == DetailCellType.address.rawValue {
            viewModel = AddressCellViewModel(restaurant: restaurant)
        } else if indexPath.row == DetailCellType.directions.rawValue {
            viewModel = DirectionsCellViewModel(restaurant: restaurant)
        }
        return viewModel
    }
}

class DetailCellViewModel {
    func getAction()->String? {
        return nil
    }
}

