//
//  BusinessesViewController.swift
//  Yelp
//
//  Created by Timothy Lee on 4/23/15.
//  Copyright (c) 2015 Timothy Lee. All rights reserved.
//

import UIKit
import CircularSpinner

class BusinessesViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UISearchBarDelegate, FilterViewControllerDelegate, UIScrollViewDelegate {
    @IBOutlet weak var tableView: UITableView!
    
    var businesses: [Business] = [Business]()
    
    var tableViewDataBackArray = [Business]()
    let searchBar = UISearchBar()
    
    var userSelectedFilterArray = [String]()
    
    var currentFilters = CurrentFilters()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        Business.searchWithTerm(term: "Thai", completion: { (businesses: [Business]?, error: Error?) -> Void in
//            
//            self.businesses = businesses
//            self.updateTableView()
//            if let businesses = businesses {
//                for business in businesses {
//                    print(business.name!)
//                    print(business.address!)
//                }
//            }
//        })
        
        self.setupTableView()
        
        self.searchBar.delegate = self
        self.navigationItem.titleView = self.searchBar
        self.apiCall()

    }
    
    
    // MARK: - NETWORK AND DATA
    var currentOffSet = 0
    func apiCall(){
        //         Example of Yelp search with more search options specified

        
        CircularSpinner.useContainerView(self.view)
        CircularSpinner.show("Loading...", animated: true, type: .indeterminate)
        
        let deals = self.currentFilters.filterDeal.contains("deal")
        Business.searchWithTerm(term: "Restaurants", sort:self.currentFilters.filterSort! , categories: self.userSelectedFilterArray, deals: deals, offSet:currentOffSet) { (responseBusinesses: [Business]?, error: Error?) -> Void in
//            self.businesses = businesses
            CircularSpinner.hide()

            self.businesses.append(contentsOf:responseBusinesses!)
            self.isMoreDataLoading = false
            self.updateTableView()
            if let businesses = responseBusinesses{
                for business in businesses {
                    print(business.name!)
                    print(business.address!)
                }
            }
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - TableView Setup, Delegates
    func setupTableView() {
        self.automaticallyAdjustsScrollViewInsets = false
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.estimatedRowHeight = 100
        self.tableView.rowHeight = UITableViewAutomaticDimension
    }
    
    func updateTableView() { //here is a chance to update tableView data with filtered array.
        self.tableViewDataBackArray = self.businesses
        
        self.tableView.reloadData()
    }
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.tableViewDataBackArray.count
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        var cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        
        if let cell = cell as? POIListCell {
            let singleBusiness = self.tableViewDataBackArray[indexPath.row]

            cell.business = singleBusiness
        }
        else {
            cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
            cell.textLabel?.text = "Custom cell load error"
        }
        return cell
    }

    
    // MARK: - ScrollView Delegate
    
    var isMoreDataLoading = false
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
        if (isMoreDataLoading == false) {
            
            
            let scrollViewContentHeight = self.tableView.contentSize.height
            //Threshold = 1 screen away
            let scrollOffsetThreshold = scrollViewContentHeight - self.tableView.bounds.size.height
            
            if (scrollView.contentOffset.y > scrollOffsetThreshold && self.tableView.isDragging) {
                self.isMoreDataLoading = true
                self.currentOffSet += 20
                self.apiCall()
            }
        }
    }
    
    
    // MARK: - UISearchBar Delegates
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        // When there is no text, filteredData is the same as the original data
        if searchText.isEmpty {
            self.tableViewDataBackArray = self.businesses
        } else {
            // The user has entered text into the search box
            // Use the filter method to iterate over all items in the data array
            // For each item, return true if the item should be included and false if the
            // item should NOT be included
            self.tableViewDataBackArray = self.businesses.filter({(dataItem: Business) -> Bool in
                // If dataItem matches the searchText, return true to include it
                let titleString = dataItem.name
                if titleString?.range(of: searchText, options: .caseInsensitive) != nil {
                    return true
                } else {
                    return false
                }
                
            })
        }
        self.tableView.reloadData()
    }
    
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        self.searchBar.showsCancelButton = true
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.showsCancelButton = false
        searchBar.text = ""
        self.searchBar(searchBar, textDidChange: searchBar.text!)
        searchBar.resignFirstResponder()
    }

    
    // MARK: - FilterViewControllerDelegate
    internal func userDidSet(filters:CurrentFilters) {
        self.currentFilters = filters
        
        //Convert Filters from Dictionary to Array
        self.userSelectedFilterArray = self.currentFilters.categories
        self.currentOffSet = 0
        self.apiCall()
    }
    
    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        if segue.identifier == "SegueToFilterNavigatonController" {
            self.prepareForSegueToFilter(segue: segue, sender: sender)
        }
    }

    func prepareForSegueToFilter(segue: UIStoryboardSegue, sender: Any?) {
        
        if let naviVC = segue.destination as? UINavigationController {
            if let filtersVC = naviVC.viewControllers[0] as? FiltersViewController {
                filtersVC.currentFilters = self.currentFilters
                filtersVC.delegate = self
            }
        }
    }
    
    
    
}
