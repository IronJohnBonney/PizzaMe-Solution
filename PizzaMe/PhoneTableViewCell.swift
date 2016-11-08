//
//  PhoneTableViewCell.swift
//  PizzaMe
//
//  Copyright © 2016 Charles Schwab & Co., Inc. All rights reserved.
//

import UIKit

class PhoneTableViewCell: DetailTableViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

    override func configureWithViewModel(viewModel: DetailCellViewModel) {
        super.configureWithViewModel(viewModel: viewModel)
        if let viewModel = viewModel as? PhoneCellViewModel {
            self.detailTextLabel?.text = viewModel.phoneNumber
            self.imageView?.image = UIImage(named: viewModel.imageName)
        }
    }
    
}
