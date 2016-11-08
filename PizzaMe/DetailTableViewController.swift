//
//  DetailTableViewController.swift
//  PizzaMe
//
//  Copyright © 2016 Charles Schwab & Co., Inc. All rights reserved.
//

import UIKit

class DetailTableViewController: UITableViewController {

    private var viewModel: DetailViewModel?
    
    func configureView() {
        self.title = viewModel?.title
    }

    var detailItem: Restaurant? {
        didSet {
            if let detailItem = detailItem {
                self.viewModel = DetailViewModel(restaurant: detailItem)
                self.configureView()
            }
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.tableFooterView = UIView()
        self.navigationController?.navigationBar.tintColor = UIColor.darkGray
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel?.availableCells.count ?? 0
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell:UITableViewCell
        
        if let cellType = viewModel?.availableCells[indexPath.row] {
            cell = tableView.dequeueReusableCell(withIdentifier: cellType.cellIdentifier, for: indexPath)
            if let cell = cell as? DetailTableViewCell {
                if let viewModel =  viewModel?.cellViewModelFor(indexPath: indexPath) {
                    cell.configureWithViewModel(viewModel: viewModel)
                }
            }
        } else {
            cell = tableView.dequeueReusableCell(withIdentifier: "DefaultCell", for: indexPath)
        }
        return cell
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let viewModel = viewModel?.cellViewModelFor(indexPath: indexPath), let action = viewModel.getAction() {
            if let url = URL(string: action) {
                UIApplication.shared.openURL(url)
            }
        }
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
