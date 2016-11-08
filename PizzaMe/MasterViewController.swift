//
//  MasterViewController.swift
//  PizzaMe
//
//  Copyright © 2016 Charles Schwab & Co., Inc. All rights reserved.
//

import UIKit
import QuartzCore

class MasterViewController: UITableViewController {

    var detailViewController: DetailTableViewController? = nil
    var viewModel:RestaurantListViewModel?
    @IBOutlet var pizzaSpinner:UIImageView!
    @IBOutlet weak var tableSortControl: UISegmentedControl!

    override func viewDidLoad() {
        super.viewDidLoad()
        if let split = self.splitViewController {
            let controllers = split.viewControllers
            self.detailViewController = (controllers[controllers.count-1] as! UINavigationController).topViewController as? DetailTableViewController
        }
        self.tableView.tableFooterView = UIView()
        self.tableView.rowHeight = UITableViewAutomaticDimension
        self.tableView.estimatedRowHeight = 100
    }

    override func viewWillAppear(_ animated: Bool) {
        self.clearsSelectionOnViewWillAppear = self.splitViewController!.isCollapsed
        super.viewWillAppear(animated)
        self.pizzaSpinner.isHidden = true
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    // MARK: - Segues

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showDetail" {
            if let indexPath = self.tableView.indexPathForSelectedRow {
                let selection = viewModel?.restaurant(indexPath: indexPath)
                let controller = (segue.destination as! UINavigationController).topViewController as! DetailTableViewController
                controller.detailItem = selection
                controller.navigationItem.leftBarButtonItem = self.splitViewController?.displayModeButtonItem
                controller.navigationItem.leftItemsSupplementBackButton = true
            }
        }
    }
    
    // MARK: - UI Handlers
    
    @IBAction func tableSortControlValueChanged(_ sender: AnyObject) {
        if (tableSortControl.selectedSegmentIndex == 0) {
            // If the viewModel has already been initialized, the table should be sorted by distance
            if let restaurantListModel = viewModel {
                viewModel?.sortByDistance()
                print(restaurantListModel)
                // Reload table view
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                    self.reloadInputViews()
                }
            }
        } else if (tableSortControl.selectedSegmentIndex == 1) {
            // If the viewModel has already been initialized, the table should be sorted alphabetically
            if let restaurantListModel = viewModel {
                
                viewModel?.sortAlphabetically()
                print(restaurantListModel)
                // Reload table view
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                    self.reloadInputViews()
                }
            }
        }
    }
    
    func toggleSpinningPizza() {
        pizzaSpinner.isHidden = !pizzaSpinner.isHidden
        if pizzaSpinner.isHidden {
            pizzaSpinner.layer.removeAllAnimations()
        } else {
            let rotationAnimation = CABasicAnimation(keyPath: "transform.rotation.z")
            rotationAnimation.toValue = Float(.pi * 2.0)
            rotationAnimation.duration = 1.0
            rotationAnimation.isCumulative = true
            rotationAnimation.repeatCount = 100
            
            pizzaSpinner.layer.add(rotationAnimation, forKey: "rotationAnimation")
        }
    }
    
    /*
     * The tableView header when the app has finished searching for pizza places and can be sorted.
     */
    func setHeaderToSortMode() {
        let headerView       = self.tableView.tableHeaderView
        let sortControl      = headerView?.viewWithTag(1) as! UISegmentedControl
        let needPizzaLabel   = headerView?.viewWithTag(2) as! UILabel
        
        let headerFrame      = headerView?.frame
        headerView?.frame     = CGRect(x: (headerFrame?.origin.x)!, y: (headerFrame?.origin.y)!, width: (headerFrame?.width)!, height: 50.0)
        
        sortControl.isHidden    = false
        needPizzaLabel.isHidden = true
        pizzaSpinner.isHidden = true
    }
    
    /*
     * This function isn't implemented in the solution, but could be used if the app is still searching for pizza places while the list is populating, so that the spinning pizza and sort buttons are both visible.
     */
    func setHeaderToIntermediateMode() {
        let headerView       = self.tableView.tableHeaderView
        let sortControl      = headerView?.viewWithTag(1) as! UISegmentedControl
        let needPizzaLabel   = headerView?.viewWithTag(2) as! UILabel
        
        let headerFrame      = headerView?.frame
        headerView?.frame    = CGRect(x: (headerFrame?.origin.x)!, y: (headerFrame?.origin.y)!, width: (headerFrame?.width)!, height: 100.0)
        
        sortControl.isHidden    = false
        needPizzaLabel.isHidden = false
        pizzaSpinner.isHidden = false
    }
    
    /*
     * The tableView header when the app is actively searching for pizza places
     */
    func setHeaderToSearchMode() {
        let headerView       = self.tableView.tableHeaderView
        let sortControl      = headerView?.viewWithTag(1) as! UISegmentedControl
        let needPizzaLabel   = headerView?.viewWithTag(2) as! UILabel
        
        let headerFrame      = headerView?.frame
        headerView?.frame     = CGRect(x: (headerFrame?.origin.x)!, y: (headerFrame?.origin.y)!, width: (headerFrame?.width)!, height: 50.0)
        
        sortControl.isHidden    = true
        needPizzaLabel.isHidden = false
        pizzaSpinner.isHidden = true
    }


    // MARK: - Table View

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel?.restaurantCount ?? 0
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        let cell = tableView.dequeueReusableCell(withIdentifier: "RestaurantCell", for: indexPath)
            
        if let restaurantCell = cell as? RestaurantTableViewCell {
            if let restaurant = viewModel?.restaurant(indexPath: indexPath) {
                restaurantCell.configure(viewModel: RestaurantCellViewModel(restaurant: restaurant))
            }
        }
        return cell
    }

    @IBAction func updateMyLocation(sender: AnyObject) {
        setHeaderToSearchMode()
        toggleSpinningPizza()
        let locationManager = LocationManager.sharedInstance
        locationManager.delegate = self
        locationManager.updateLocation()
    }
    
}

extension MasterViewController : LocationManagerDelegate {
    func didUpdate(zipCode: String) {
        SearchService().resultsByZip(zipCode: zipCode, completion: { (response, error) in
            self.toggleSpinningPizza()
            if error != nil {
                let alertController = UIAlertController(title: NSLocalizedString("Error", comment: ""), message: NSLocalizedString("Unable to find any pizza near you.", comment: ""), preferredStyle: .alert)
                let defaultAction = UIAlertAction(title: NSLocalizedString("OK", comment: ""), style: .default) { (action) in
                }
                alertController.addAction(defaultAction)
                DispatchQueue.main.async {
                    self.present(alertController, animated: true, completion: {
                    })
                }
            }
            else if let response = response {
                self.viewModel = RestaurantListViewModel(restaurantList: response.restaurantList)
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                    // TODO: Set the header view to be a segmented control view
                    //self.tableView.tableHeaderView = UIView()
                    self.toggleSpinningPizza()
                    self.setHeaderToSortMode()
                }
            }
        })
    }
    
    func didFail(error: NSError) {
        toggleSpinningPizza()
        let alertController = UIAlertController(title: NSLocalizedString("Location Error", comment: ""), message: NSLocalizedString("An error occurred while getting your location.", comment: ""), preferredStyle: .alert)
        let defaultAction = UIAlertAction(title: NSLocalizedString("OK", comment: ""), style: .default) { (action) in
        }
        alertController.addAction(defaultAction)
        DispatchQueue.main.async {
            self.present(alertController, animated: true, completion: {
            })
        }
    }
}

