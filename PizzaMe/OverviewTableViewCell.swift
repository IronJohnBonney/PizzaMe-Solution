//
//  OverviewTableViewCell.swift
//  PizzaMe
//
//  Copyright © 2016 Charles Schwab & Co., Inc. All rights reserved.
//

import UIKit

class OverviewTableViewCell: DetailTableViewCell {

    @IBOutlet var nameLabel:UILabel!
    @IBOutlet var cuisineLabel:UILabel!
    @IBOutlet var distanceLabel:UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

    override func configureWithViewModel(viewModel: DetailCellViewModel) {
        super.configureWithViewModel(viewModel: viewModel)
        if let viewModel = viewModel as? OverviewCellViewModel {
            nameLabel.text = viewModel.name
            distanceLabel.text = viewModel.distance
        }
    }
}

