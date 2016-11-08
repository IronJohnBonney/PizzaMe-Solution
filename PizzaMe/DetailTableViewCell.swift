//
//  DetailCellProtocol.swift
//  PizzaMe
//
//  Copyright © 2016 Charles Schwab & Co., Inc. All rights reserved.
//

import UIKit

class DetailTableViewCell: UITableViewCell {
    func configureWithViewModel(viewModel: DetailCellViewModel) {
        selectionStyle = (viewModel.getAction() != nil) ? .default : .none
    }

}
