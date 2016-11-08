//
//  AddressTableViewCell.swift
//  PizzaMe
//
//  Copyright © 2016 Charles Schwab & Co., Inc. All rights reserved.
//

import UIKit

class AddressTableViewCell: DetailTableViewCell {

    @IBOutlet var addressLabel: UILabel!
    @IBOutlet var cityStateLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    override func configureWithViewModel(viewModel: DetailCellViewModel) {
        super.configureWithViewModel(viewModel: viewModel)
        if let viewModel = viewModel as? AddressCellViewModel {
            self.addressLabel.text = viewModel.address
            self.cityStateLabel.text = viewModel.cityState
            self.imageView?.image = UIImage(named: viewModel.imageName)
        }
    }

}
